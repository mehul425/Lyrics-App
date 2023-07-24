import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/result.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/youtubeList/youtube_list_event.dart';
import 'package:juna_bhajan/view/youtubeList/youtube_list_state.dart';
import 'package:rxdart/rxdart.dart' show ZipStream;
import 'package:stream_transform/stream_transform.dart';
import 'package:tuple/tuple.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class YoutubeListBloc extends Bloc<YoutubeListEvent, Result<YoutubeListState>> {
  final ApiRepository apiRepository;
  final AnalyticsRepository analyticsRepository;

  YoutubeListBloc({
    required this.apiRepository,
    required this.analyticsRepository,
  }) : super(const Result.loading()) {
    on<LoadYoutubeListDataEvent>((event, emit) async {
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
        var bhajanMainList = value.item7
            .map((e) => Tuple2(
                  value.item2
                      .firstWhereOrNull((element) => element.id == e.bhajanId),
                  e,
                ))
            .where((element) => element.item1 != null)
            .map((e) => Tuple2(e.item1!, e.item2))
            .toList()
            .sorted((a, b) => a.item1.nameGuj.compareTo(b.item1.nameGuj));

        emit(
          Result.success(
            data: YoutubeListState(
              bhajanMainList: bhajanMainList,
              bhajanList: bhajanMainList,
              authorList: value.item1,
              typeList: value.item3,
              tagList: value.item4,
              relatedList: value.item5,
              singerList: value.item6,
              author: null,
              type: null,
              tag: null,
              related: null,
              singer: null,
              isExpanded: false,
            ),
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
    on<ToggleExpandedEvent>((event, emit) {
      state.whenOrNull(success: (data) {
        emit(Result.success(
            data: data.copyWith(
          isExpanded: !data.isExpanded,
        )));
        onApplyFilter(emit);
      });
    });
  }

  void onApplyFilter(Emitter<Result<YoutubeListState>> emit) {
    state.whenOrNull(success: (data) {
      var tempList = data.bhajanMainList;
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
            .where((element) =>
                element.item2.singer?.contains(data.singer!.id) ?? false)
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
