// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    BhajanListRouter.name: (routeData) {
      final args = routeData.argsAs<BhajanListRouterArgs>(
          orElse: () => const BhajanListRouterArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BhajanListView(
          bhajanListType: args.bhajanListType,
          typeId: args.typeId,
          tagId: args.tagId,
          authorId: args.authorId,
          relatedId: args.relatedId,
          key: args.key,
        ),
      );
    },
    HomeRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    FontSettingRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FontSettingView(),
      );
    },
    AuthorListRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthorListView(),
      );
    },
    AboutUsRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutUsView(),
      );
    },
    BhajanRouter.name: (routeData) {
      final args = routeData.argsAs<BhajanRouterArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BhajanView(
          bhajan: args.bhajan,
          key: args.key,
        ),
      );
    },
    YoutubeListRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const YoutubeListView(),
      );
    },
    AuthorRouter.name: (routeData) {
      final args = routeData.argsAs<AuthorRouterArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthorView(
          author: args.author,
          key: args.key,
        ),
      );
    },
    RelatedListRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RelatedListView(),
      );
    },
    FavoriteRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteView(),
      );
    },
    SingerListRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SingerListView(),
      );
    },
    DashboardRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardView(),
      );
    },
    SettingRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingView(),
      );
    },
    SingerRouter.name: (routeData) {
      final args = routeData.argsAs<SingerRouterArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SingerView(
          singer: args.singer,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [BhajanListView]
class BhajanListRouter extends PageRouteInfo<BhajanListRouterArgs> {
  BhajanListRouter({
    BhajanListType? bhajanListType,
    int? typeId,
    int? tagId,
    String? authorId,
    String? relatedId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BhajanListRouter.name,
          args: BhajanListRouterArgs(
            bhajanListType: bhajanListType,
            typeId: typeId,
            tagId: tagId,
            authorId: authorId,
            relatedId: relatedId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BhajanListRouter';

  static const PageInfo<BhajanListRouterArgs> page =
      PageInfo<BhajanListRouterArgs>(name);
}

class BhajanListRouterArgs {
  const BhajanListRouterArgs({
    this.bhajanListType,
    this.typeId,
    this.tagId,
    this.authorId,
    this.relatedId,
    this.key,
  });

  final BhajanListType? bhajanListType;

  final int? typeId;

  final int? tagId;

  final String? authorId;

  final String? relatedId;

  final Key? key;

  @override
  String toString() {
    return 'BhajanListRouterArgs{bhajanListType: $bhajanListType, typeId: $typeId, tagId: $tagId, authorId: $authorId, relatedId: $relatedId, key: $key}';
  }
}

/// generated route for
/// [HomeView]
class HomeRouter extends PageRouteInfo<void> {
  const HomeRouter({List<PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FontSettingView]
class FontSettingRouter extends PageRouteInfo<void> {
  const FontSettingRouter({List<PageRouteInfo>? children})
      : super(
          FontSettingRouter.name,
          initialChildren: children,
        );

  static const String name = 'FontSettingRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthorListView]
class AuthorListRouter extends PageRouteInfo<void> {
  const AuthorListRouter({List<PageRouteInfo>? children})
      : super(
          AuthorListRouter.name,
          initialChildren: children,
        );

  static const String name = 'AuthorListRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AboutUsView]
class AboutUsRouter extends PageRouteInfo<void> {
  const AboutUsRouter({List<PageRouteInfo>? children})
      : super(
          AboutUsRouter.name,
          initialChildren: children,
        );

  static const String name = 'AboutUsRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BhajanView]
class BhajanRouter extends PageRouteInfo<BhajanRouterArgs> {
  BhajanRouter({
    required Bhajan bhajan,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BhajanRouter.name,
          args: BhajanRouterArgs(
            bhajan: bhajan,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BhajanRouter';

  static const PageInfo<BhajanRouterArgs> page =
      PageInfo<BhajanRouterArgs>(name);
}

class BhajanRouterArgs {
  const BhajanRouterArgs({
    required this.bhajan,
    this.key,
  });

  final Bhajan bhajan;

  final Key? key;

  @override
  String toString() {
    return 'BhajanRouterArgs{bhajan: $bhajan, key: $key}';
  }
}

/// generated route for
/// [YoutubeListView]
class YoutubeListRouter extends PageRouteInfo<void> {
  const YoutubeListRouter({List<PageRouteInfo>? children})
      : super(
          YoutubeListRouter.name,
          initialChildren: children,
        );

  static const String name = 'YoutubeListRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthorView]
class AuthorRouter extends PageRouteInfo<AuthorRouterArgs> {
  AuthorRouter({
    required Author author,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthorRouter.name,
          args: AuthorRouterArgs(
            author: author,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthorRouter';

  static const PageInfo<AuthorRouterArgs> page =
      PageInfo<AuthorRouterArgs>(name);
}

class AuthorRouterArgs {
  const AuthorRouterArgs({
    required this.author,
    this.key,
  });

  final Author author;

  final Key? key;

  @override
  String toString() {
    return 'AuthorRouterArgs{author: $author, key: $key}';
  }
}

/// generated route for
/// [RelatedListView]
class RelatedListRouter extends PageRouteInfo<void> {
  const RelatedListRouter({List<PageRouteInfo>? children})
      : super(
          RelatedListRouter.name,
          initialChildren: children,
        );

  static const String name = 'RelatedListRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoriteView]
class FavoriteRouter extends PageRouteInfo<void> {
  const FavoriteRouter({List<PageRouteInfo>? children})
      : super(
          FavoriteRouter.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SingerListView]
class SingerListRouter extends PageRouteInfo<void> {
  const SingerListRouter({List<PageRouteInfo>? children})
      : super(
          SingerListRouter.name,
          initialChildren: children,
        );

  static const String name = 'SingerListRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashboardView]
class DashboardRouter extends PageRouteInfo<void> {
  const DashboardRouter({List<PageRouteInfo>? children})
      : super(
          DashboardRouter.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingView]
class SettingRouter extends PageRouteInfo<void> {
  const SettingRouter({List<PageRouteInfo>? children})
      : super(
          SettingRouter.name,
          initialChildren: children,
        );

  static const String name = 'SettingRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SingerView]
class SingerRouter extends PageRouteInfo<SingerRouterArgs> {
  SingerRouter({
    required Singer singer,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SingerRouter.name,
          args: SingerRouterArgs(
            singer: singer,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SingerRouter';

  static const PageInfo<SingerRouterArgs> page =
      PageInfo<SingerRouterArgs>(name);
}

class SingerRouterArgs {
  const SingerRouterArgs({
    required this.singer,
    this.key,
  });

  final Singer singer;

  final Key? key;

  @override
  String toString() {
    return 'SingerRouterArgs{singer: $singer, key: $key}';
  }
}
