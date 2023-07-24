import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/result.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/bhajanList/bhajan_list_event.dart';
import 'package:juna_bhajan/view/bhajanList/bhajan_list_state.dart';
import 'package:rxdart/rxdart.dart' show ZipStream;
import 'package:juna_bhajan/data/model/type.dart';
import 'package:tuple/tuple.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class BhajanListBloc extends Bloc<BhajanListEvent, Result<BhajanListState>> {
  final ApiRepository apiRepository;
  final AnalyticsRepository analyticsRepository;
  late Fuzzy<Tuple2<Bhajan, List<Youtube>>> fuzzy;

  BhajanListBloc({
    required this.apiRepository,
    required this.analyticsRepository,
  }) : super(const Result.loading()) {
    on<LoadBhajanListDataEvent>((event, emit) async {
      await ZipStream.zip7<
              List<Author>,
              List<Bhajan>,
              List<Type>,
              List<Tag>,
              List<Related>,
              List<Singer>,
              List<Youtube>,
              Tuple7<List<Author>, List<Bhajan>, List<Type>, List<Tag>,
                  List<Related>, List<Singer>, List<Youtube>>>(
          apiRepository.getAuthorList(),
          apiRepository.getBhajanList(),
          apiRepository.getTypeList(),
          apiRepository.getTagList(),
          apiRepository.getRelatedList(),
          apiRepository.getSingerList(),
          apiRepository.getYoutubeList(),
          (a, b, c, d, e, f, g) => Tuple7<
              List<Author>,
              List<Bhajan>,
              List<Type>,
              List<Tag>,
              List<Related>,
              List<Singer>,
              List<Youtube>>(a, b, c, d, e, f, g)).first.then((value) {
        Type? type;
        Tag? tag;
        Author? author;
        Related? related;
        Singer? singer;
        if (event.bhajanListType != null) {
          switch (event.bhajanListType!) {
            case BhajanListType.type:
              type = value.item3.firstWhereOrNull(
                  (element) => element.typeId == event.typeId);
              if (type != null) {
                analyticsRepository.logFilter("type", type.id!, type.nameGuj);
              } else {
                FimberLog("BhajanListBloc").e(
                    "Type is not match : ${event.typeId} ${value.item3.map((e) => e.typeId).toList()}");
              }
              break;
            case BhajanListType.tag:
              tag = value.item4
                  .firstWhereOrNull((element) => element.tagId == event.tagId);
              if (tag != null) {
                analyticsRepository.logFilter("tag", tag.id!, tag.nameGuj);
              } else {
                FimberLog("BhajanListBloc").e(
                    "Tag is not match : ${event.tagId} ${value.item4.map((e) => e.tagId).toList()}");
              }
              break;
            case BhajanListType.author:
              author = value.item1
                  .firstWhereOrNull((element) => element.id == event.authorId);
              if (author != null) {
                analyticsRepository.logFilter(
                    "author", author.id!, author.name);
              } else {
                FimberLog("BhajanListBloc").e(
                    "Author is not match : ${event.authorId} ${value.item1.map((e) => e.id).toList()}");
              }
              break;
            case BhajanListType.related:
              related = value.item5
                  .firstWhereOrNull((element) => element.id == event.relatedId);
              if (related != null) {
                analyticsRepository.logFilter(
                    "related", related.id!, related.nameGuj);
              } else {
                FimberLog("BhajanListBloc").e(
                    "Related is not match : ${event.relatedId} ${value.item5.map((e) => e.id).toList()}");
              }
              break;
          }
        }
        var bhajanMainList = value.item2
            .map((e) => Tuple2(
                  e,
                  e.youtube!
                      .map((e) => value.item7
                          .firstWhereOrNull((element) => element.id == e))
                      .whereNotNull()
                      .toList(),
                ))
            .toList();

        emit(
          Result.success(
            data: BhajanListState(
              bhajanMainList: bhajanMainList,
              bhajanList: bhajanMainList,
              authorList: value.item1,
              typeList: value.item3,
              tagList: value.item4,
              relatedList: value.item5,
              singerList: value.item6,
              author: author,
              type: type,
              tag: tag,
              related: related,
              singer: singer,
              isSearchActive: false,
              search: "",
            ),
          ),
        );

        fuzzy = Fuzzy<Tuple2<Bhajan, List<Youtube>>>(
          bhajanMainList,
          options: FuzzyOptions(
            minMatchCharLength: 2,
            keys: [
              WeightedKey<Tuple2<Bhajan, List<Youtube>>>(
                  name: "english", weight: 1.0, getter: (e) => e.item1.nameEng),
              WeightedKey<Tuple2<Bhajan, List<Youtube>>>(
                  name: "gujarati",
                  weight: 1.0,
                  getter: (e) => e.item1.nameGuj),
              // WeightedKey<Bhajan>(
              //     name: "gujaratiBhajan", weight: 1.0, getter: (e) => e.bhajan),
            ],
          ),
        );

        onApplyFilter(emit);
      }, onError: (e, str) {
        emit(Result.failure(object: e));
        FimberLog("BhajanListBloc")
            .e("Loading Bhajan List", ex: e, stacktrace: str);
      });
    });
    on<ChangeAuthorEvent>((event, emit) {
      state.whenOrNull(success: (data) {
        emit(Result.success(data: data.copyAuthor(author: event.author)));
        if (event.author != null) {
          analyticsRepository.logFilter(
              "author", event.author!.id!, event.author!.name);
        }
        onApplyFilter(emit);
      });
    });
    on<ChangeTypeEvent>((event, emit) {
      state.whenOrNull(success: (data) {
        emit(Result.success(data: data.copyType(type: event.type)));
        if (event.type != null) {
          analyticsRepository.logFilter(
              "type", event.type!.id!, event.type!.nameGuj);
        }
        onApplyFilter(emit);
      });
    });
    on<ChangeTagEvent>((event, emit) {
      state.whenOrNull(success: (data) {
        emit(Result.success(data: data.copyTag(tag: event.tag)));
        if (event.tag != null) {
          analyticsRepository.logFilter(
              "tag", event.tag!.id!, event.tag!.nameGuj);
        }
        onApplyFilter(emit);
      });
    });
    on<ChangeRelatedEvent>((event, emit) {
      state.whenOrNull(success: (data) {
        emit(Result.success(data: data.copyRelated(related: event.related)));
        if (event.related != null) {
          analyticsRepository.logFilter(
              "related", event.related!.id!, event.related!.nameGuj);
        }
        onApplyFilter(emit);
      });
    });
    on<ChangeSingerEvent>((event, emit) {
      state.whenOrNull(success: (data) {
        emit(Result.success(data: data.copySinger(singer: event.singer)));
        if (event.singer != null) {
          analyticsRepository.logFilter(
              "singer", event.singer!.id!, event.singer!.name);
        }

        onApplyFilter(emit);
      });
    });
    on<ClearFilterEvent>((event, emit) {
      state.whenOrNull(success: (data) {
        emit(Result.success(
            data: data.copyAuthorTypeTagRelatedSinger(
          related: null,
          author: null,
          type: null,
          tag: null,
          singer: null,
        )));
        onApplyFilter(emit);
      });
    });
    on<ToggleSearchEvent>((event, emit) {
      state.whenOrNull(success: (data) {
        emit(Result.success(
            data: data.copyWith(isSearchActive: !data.isSearchActive)));
        onApplyFilter(emit);
      });
    });
    on<SearchTextChangeEvent>((event, emit) {
      state.whenOrNull(success: (data) {
        emit(Result.success(data: data.copyWith(search: event.text)));
        onApplyFilter(emit);
      });
    }, transformer: throttleDroppable(throttleDuration));
  }

  void onApplyFilter(Emitter<Result<BhajanListState>> emit) {
    state.whenOrNull(success: (data) {
      var tempList = fuzzy.search(data.search).map((e) => e.item).toList();
      if (data.author != null) {
        tempList = tempList
            .where((element) => element.item1.author == data.author!.id)
            .toList();
      }

      if (data.type != null) {
        tempList = tempList
            .where((element) => element.item1.type == data.type!.typeId)
            .toList();
      }

      if (data.tag != null) {
        tempList = tempList
            .where((element) => element.item1.tag == data.tag!.tagId)
            .toList();
      }

      if (data.related != null) {
        tempList = tempList
            .where((element) => element.item1.relatedTo == data.related!.id)
            .toList();
      }

      if (data.singer != null) {
        tempList = tempList
            .where((element) => element.item2
                .map((e) => e.singer!)
                .expand((element) => element)
                .contains(data.singer!.id))
            .toList();
      }

      emit(
        Result.success(
          data: data.copyWith(bhajanList: tempList),
        ),
      );
    });
  }
}
