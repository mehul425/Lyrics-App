import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/view/aboutUs/about_us_view.dart';
import 'package:juna_bhajan/view/author/author_view.dart';
import 'package:juna_bhajan/view/authorList/author_list_view.dart';
import 'package:juna_bhajan/view/bhajan/bhajan_view.dart';
import 'package:juna_bhajan/view/bhajanList/bhajan_list_view.dart';
import 'package:juna_bhajan/view/dashboard/dashboard_view.dart';
import 'package:juna_bhajan/view/favorite/favorite_view.dart';
import 'package:juna_bhajan/view/fontSetting/font_setting_view.dart';
import 'package:juna_bhajan/view/home/home_view.dart';
import 'package:juna_bhajan/view/relatedList/related_list_view.dart';
import 'package:juna_bhajan/view/setting/setting_view.dart';
import 'package:juna_bhajan/view/singer/singer_view.dart';
import 'package:juna_bhajan/view/singerList/singer_list_view.dart';
import 'package:juna_bhajan/view/youtubeList/youtube_list_view.dart';

part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
// extend the generated private router
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: "/",
      page: DashboardRouter.page,
      children: [
        AutoRoute(path: "", page: HomeRouter.page),
        AutoRoute(path: "author", page: AuthorRouter.page),
        AutoRoute(path: "author-list", page: AuthorListRouter.page),
        AutoRoute(path: "bhajan", page: BhajanRouter.page),
        AutoRoute(path: "bhajan-list", page: BhajanListRouter.page),
        AutoRoute(path: "singer", page: SingerRouter.page),
        AutoRoute(path: "singer-list", page: SingerListRouter.page),
        AutoRoute(path: "youtube-list", page: YoutubeListRouter.page),
        AutoRoute(path: "related-list", page: RelatedListRouter.page),
        AutoRoute(path: "related-list", page: RelatedListRouter.page),
        AutoRoute(path: "favorite", page: FavoriteRouter.page),
        AutoRoute(path: "setting", page: SettingRouter.page),
        AutoRoute(path: "about-us", page: AboutUsRouter.page),
        AutoRoute(path: "font-setting", page: FontSettingRouter.page),
      ],
    ),
  ];
}
