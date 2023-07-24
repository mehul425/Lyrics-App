import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/change_data.dart';
import 'package:juna_bhajan/data/model/home_model.dart';
import 'package:juna_bhajan/data/model/other.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';
import 'package:juna_bhajan/data/model/update.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/data/repository/local_repository.dart';
import 'package:juna_bhajan/extension/stream_extension.dart';

class HomeRepository {
  final ApiRepository apiRepository;
  final LocalRepository localRepository;

  const HomeRepository({
    required this.apiRepository,
    required this.localRepository,
  });

  Future<HomeModel> getHomeDetails() async {
    // List<ChangeData> localChangeList = localRepository.getChangeList();
    // List<ChangeData> newChangeList = await apiRepository.getChangeList().first;

    bool refresh = true;
    ChangeData changeData = ChangeData.initial();

    // if (localChangeList.isEmpty) {
    //   refresh = true;
    // } else {
    //   if (localChangeList.length < newChangeList.length) {
    //     FimberLog("HomeRepository local").e(
    //         "${localChangeList.map((e) => e.id)} ${newChangeList.map((e) => e.id)}");
    //
    //     changeData = newChangeList.mergeChangeDataList(localChangeList.length);
    //
    //     FimberLog("HomeRepository").e("$changeData");
    //     refresh = false;
    //   } else {
    //     refresh = false;
    //   }
    // }

    return zip13<
        List<Author>,
        List<Bhajan>,
        List<Singer>,
        List<Youtube>,
        List<String>,
        List<String>,
        List<String>,
        List<String>,
        List<Type>,
        List<Tag>,
        List<Related>,
        Update,
        Other,
        HomeModel>(
      apiRepository.getAuthorList(
        refresh: refresh,
        ids: changeData.author,
      ),
      apiRepository.getBhajanList(
        refresh: refresh,
        ids: changeData.bhajan,
      ),
      apiRepository.getSingerList(
        refresh: refresh,
        ids: changeData.singer,
      ),
      apiRepository.getYoutubeList(
        refresh: refresh,
        ids: changeData.youtube,
      ),
      apiRepository.getTopAuthorList(
          refresh:
              changeData.topAuthor == null ? refresh : changeData.topAuthor!),
      apiRepository.getNewAddedBhajanList(
          refresh:
              changeData.newAdded == null ? refresh : changeData.newAdded!),
      apiRepository.getOurFavoriteBhajanList(
          refresh: changeData.ourFavorite == null
              ? refresh
              : changeData.ourFavorite!),
      apiRepository.getTopYoutubeBhajanList(
          refresh:
              changeData.topYoutube == null ? refresh : changeData.topYoutube!),
      apiRepository.getTypeList(
        refresh: refresh,
        ids: changeData.type,
      ),
      apiRepository.getTagList(
        refresh: refresh,
        ids: changeData.tag,
      ),
      apiRepository.getRelatedList(
        refresh: refresh,
        ids: changeData.related,
      ),
      apiRepository.getUpdate(
          refresh: changeData.update == null ? refresh : changeData.update!),
      apiRepository.getOther(
          refresh: changeData.other == null ? refresh : changeData.other!),
      (a, b, c, d, e, f, g, h, i, j, k, l, m) => HomeModel(
        authorList: a,
        bhajanList: b,
        singleList: c,
        youtubeList: d,
        topAuthorList: e,
        newAddBhajanList: f,
        ourFavoriteBhajanList: g,
        topYoutubeBhajanList: h,
        typeList: i,
        tagList: j,
        relatedList: k,
        update: l,
        other: m,
      ),
    ).first;
  }

  Future<HomeModel?> getHomeDetailsFromLocal() async {
    List<ChangeData> localChangeList = localRepository.getChangeList();
    if (localChangeList.isNotEmpty) {
      return zip13<
          List<Author>,
          List<Bhajan>,
          List<Singer>,
          List<Youtube>,
          List<String>,
          List<String>,
          List<String>,
          List<String>,
          List<Type>,
          List<Tag>,
          List<Related>,
          Update,
          Other,
          HomeModel>(
        apiRepository.getAuthorList(),
        apiRepository.getBhajanList(),
        apiRepository.getSingerList(),
        apiRepository.getYoutubeList(),
        apiRepository.getTopAuthorList(),
        apiRepository.getNewAddedBhajanList(),
        apiRepository.getOurFavoriteBhajanList(),
        apiRepository.getTopYoutubeBhajanList(),
        apiRepository.getTypeList(),
        apiRepository.getTagList(),
        apiRepository.getRelatedList(),
        apiRepository.getUpdate(),
        apiRepository.getOther(),
        (a, b, c, d, e, f, g, h, i, j, k, l, m) => HomeModel(
          authorList: a,
          bhajanList: b,
          singleList: c,
          youtubeList: d,
          topAuthorList: e,
          newAddBhajanList: f,
          ourFavoriteBhajanList: g,
          topYoutubeBhajanList: h,
          typeList: i,
          tagList: j,
          relatedList: k,
          update: l,
          other: m,
        ),
      ).first;
    } else {
      return Future.value(null);
    }
  }
}
