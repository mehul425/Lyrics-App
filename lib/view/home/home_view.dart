import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/app_colors.dart';
import 'package:juna_bhajan/core/color_scheme.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/core/dimens.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/model/user.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/extension/other_extension.dart';
import 'package:juna_bhajan/view/common/bhajan_item_view.dart';
import 'package:juna_bhajan/view/common/common_alert_dialog.dart';
import 'package:juna_bhajan/view/common/common_cached_network_image_view.dart';
import 'package:juna_bhajan/view/common/common_scaffold_view.dart';
import 'package:juna_bhajan/view/common/error_view.dart';
import 'package:juna_bhajan/view/common/fixed_size_progress_bar.dart';
import 'package:juna_bhajan/view/common/no_internet_view.dart';
import 'package:juna_bhajan/view/common/rate_dialog.dart';
import 'package:juna_bhajan/view/common/update_dialog.dart';
import 'package:juna_bhajan/view/common/youtube_item_view.dart';
import 'package:juna_bhajan/view/home/home_bloc.dart';
import 'package:juna_bhajan/view/home/home_event.dart';
import 'package:juna_bhajan/view/home/home_state.dart';
import 'package:juna_bhajan/view/setting/setting_bloc.dart';
import 'package:juna_bhajan/view/setting/setting_event.dart';
import 'package:juna_bhajan/view/setting/setting_state.dart';
import 'package:store_redirect/store_redirect.dart';

@RoutePage(name: 'HomeRouter')
class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldView(
      showLanding: false,
      title: "app_name".tr(),
      actions: [
        BlocBuilder<HomeBloc, ResultState<HomeState>>(
          builder: (context, state) {
            return state.maybeWhen(
              success: (data) {
                return BlocSelector<SettingBloc, SettingState, UserData?>(
                  selector: (state) => state.user,
                  builder: (context, state) {
                    return state == null
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              context.router.push(const FavoriteRouter());
                            },
                            customBorder: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.favorite_border_rounded),
                            ),
                          );
                  },
                );
              },
              orElse: () => const SizedBox(),
            );
          },
        ),
        BlocBuilder<HomeBloc, ResultState<HomeState>>(
          builder: (context, state) {
            return state.maybeWhen(
              success: (data) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () {
                    context.router.push(const SettingRouter());
                  },
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.settings),
                  ),
                ),
              ),
              orElse: () => const SizedBox(width: 48),
            );
          },
        ),
      ],
      body: BlocConsumer<HomeBloc, ResultState<HomeState>>(
        listenWhen: (previous, current) {
          return previous.whenOrNull(
                      success: (data) => data.canShowRatingDialog) !=
                  current.whenOrNull(
                      success: (data) => data.canShowRatingDialog) ||
              previous.whenOrNull(success: (data) => data.currentAppVersion) !=
                  current.whenOrNull(
                      success: (data) => data.currentAppVersion) ||
              previous.whenOrNull(
                      success: (data) => data.update.minAppVersion) !=
                  current.whenOrNull(
                      success: (data) => data.update.minAppVersion);
        },
        listener: (context, result) {
          result.whenOrNull(
            success: (data) {
              if (data.currentAppVersion < data.update.minAppVersion) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const CommonAlertDialog(child: UpdateDialog()),
                );
              } else if (data.canShowRatingDialog) {
                context.read<AnalyticsRepository>().logRateUsDialogShow();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const CommonAlertDialog(child: RateDialog()),
                ).then((value) {
                  if (value != null) {
                    if (value) {
                      context.read<AnalyticsRepository>().logRateUsRated();
                      context.read<HomeBloc>().add(const RatedStatusEvent());
                    } else {
                      context.read<AnalyticsRepository>().logRateUsLater();
                      context
                          .read<HomeBloc>()
                          .add(const RemindMeLaterStatusEvent());
                    }
                  }
                });
              }
            },
          );
        },
        builder: (context, result) {
          return result.when(
            loading: () => const FixedSizeProgressBar(height: 400),
            success: (state) => Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Dimens.horizontalPadding,
                              right: Dimens.verticalPadding,
                              bottom: 6,
                              top: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "author".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 18),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  context.router.push(const AuthorListRouter());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "view_all".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.blackLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 108,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.horizontalPadding),
                            itemCount: state.topAuthorList.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  context.router.push(
                                    AuthorRouter(
                                      author: state.topAuthorList[index],
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: [
                                      CommonCachedNetworkImageView(
                                        imageUrl:
                                            state.topAuthorList[index].imageUrl,
                                        height: 80,
                                        width: 80,
                                        radius: 40,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        state.topAuthorList[index].name,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: Dimens.horizontalPadding,
                            right: Dimens.verticalPadding,
                            top: 12,
                            bottom: 6,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "new_added_bhajan".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 18),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  context.router.push(BhajanListRouter());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "view_all".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.blackLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.newAddedBhajanList.length + 2,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            endIndent: 16,
                            indent: 16,
                          ),
                          itemBuilder: (context, index) {
                            if (index == 0 ||
                                state.newAddedBhajanList.length + 1 == index) {
                              return const SizedBox();
                            } else {
                              return BhajanItemView(
                                bhajan: state.newAddedBhajanList[index - 1],
                                onTap: (bhajan) {
                                  context.router
                                      .push(BhajanRouter(bhajan: bhajan));
                                },
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: Dimens.horizontalPadding,
                            right: Dimens.verticalPadding,
                            top: 12,
                            bottom: 6,
                          ),
                          child: Text(
                            "type".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 36,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.horizontalPadding),
                            itemCount: state.typeList.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                context.router.push(BhajanListRouter(
                                  bhajanListType: BhajanListType.type,
                                  typeId: state.typeList[index].typeId,
                                ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                alignment: Alignment.center,
                                height: 36,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      state.typeList[index].startColor
                                          .toColor(),
                                      state.typeList[index].centerColor
                                          .toColor(),
                                      state.typeList[index].endColor.toColor(),
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  height: 34,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: Text(
                                        state.typeList[index].nameGuj,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //     left: Dimens.horizontalPadding,
                        //     right: Dimens.verticalPadding,
                        //     top: 12,
                        //     bottom: 6,
                        //   ),
                        //   child: Text(
                        //     "tag".tr(),
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .titleSmall!
                        //         .copyWith(fontSize: 18),
                        //   ),
                        // ),
                        SizedBox(
                          height: 36,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.horizontalPadding),
                            itemCount: state.tagList.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                context.router.push(BhajanListRouter(
                                  bhajanListType: BhajanListType.tag,
                                  tagId: state.tagList[index].tagId,
                                ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                height: 34,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .backgroundColor,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Text(
                                      state.tagList[index].nameGuj,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: Dimens.horizontalPadding,
                            right: Dimens.verticalPadding,
                            top: 12,
                            bottom: 6,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "gods".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 18),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  context.router
                                      .push(const RelatedListRouter());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "view_all".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.blackLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 118,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.horizontalPadding),
                            itemCount: state.relatedList.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                context.router.push(BhajanListRouter(
                                  bhajanListType: BhajanListType.related,
                                  relatedId: state.relatedList[index].id,
                                ));
                              },
                              child: SizedBox(
                                width: 90,
                                child: Column(
                                  children: [
                                    CommonCachedNetworkImageView(
                                      imageUrl:
                                          state.relatedList[index].imageUrl,
                                      height: 90,
                                      width: 80,
                                      radius: 4,
                                      shape: BoxShape.rectangle,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      state.relatedList[index].nameGuj,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: Dimens.horizontalPadding,
                            right: Dimens.verticalPadding,
                            top: 6,
                            bottom: 6,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "our_favorite_bhajan".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 18),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  context.router.push(BhajanListRouter());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "view_all".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.blackLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.ourFavoriteBhajanList.length + 2,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            endIndent: 16,
                            indent: 16,
                          ),
                          itemBuilder: (context, index) {
                            if (index == 0 ||
                                state.ourFavoriteBhajanList.length + 1 ==
                                    index) {
                              return const SizedBox();
                            } else {
                              return BhajanItemView(
                                bhajan: state.ourFavoriteBhajanList[index - 1],
                                onTap: (bhajan) {
                                  context.router
                                      .push(BhajanRouter(bhajan: bhajan));
                                },
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Dimens.horizontalPadding,
                              right: Dimens.verticalPadding,
                              bottom: 6,
                              top: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "singer".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 18),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  context.router.push(const SingerListRouter());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "view_all".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.blackLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 108,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.horizontalPadding),
                            itemCount: state.singerList.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  context.router.push(
                                    SingerRouter(
                                      singer: state.singerList[index],
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: [
                                      CommonCachedNetworkImageView(
                                        imageUrl:
                                            state.singerList[index].imageUrl,
                                        height: 80,
                                        width: 80,
                                        radius: 40,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        state.singerList[index].name,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: Dimens.horizontalPadding,
                            right: Dimens.verticalPadding,
                            top: 6,
                            bottom: 6,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "youtube_bhajan".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 18),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  context.router
                                      .push(const YoutubeListRouter());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "view_all".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.blackLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.topYoutubeBhajanList.length + 2,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            endIndent: 16,
                            indent: 16,
                          ),
                          itemBuilder: (context, index) {
                            if (index == 0 ||
                                state.topYoutubeBhajanList.length + 1 ==
                                    index) {
                              return const SizedBox();
                            } else {
                              return YoutubeItemView(
                                tuple2: state.topYoutubeBhajanList[index - 1],
                                onTap: (tuple2) {
                                  context.pushRoute(
                                      BhajanRouter(bhajan: tuple2.item1));
                                },
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                MiniAppUpdateView(
                  currentAppVersion: state.currentAppVersion,
                  latestAppVersion: state.update.latestAppVersion,
                ),
              ],
            ),
            failure: (e) => ErrorView(object: e),
            noInternet: () => NoInternetView(
              onRefresh: () {
                context.read<HomeBloc>().add(const LoadHomeDataEvent());
                context
                    .read<SettingBloc>()
                    .add(const LoadInitialSettingDataEvent());
              },
            ),
          );
        },
      ),
    );
  }
}

class MiniAppUpdateView extends StatelessWidget {
  final int currentAppVersion;
  final int latestAppVersion;

  const MiniAppUpdateView(
      {required this.currentAppVersion,
      required this.latestAppVersion,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return currentAppVersion < latestAppVersion
        ? SizedBox(
            height: kToolbarHeight,
            child: InkWell(
              onTap: () {
                context.read<AnalyticsRepository>().logOptionalAppUpdate();
                StoreRedirect.redirect();
              },
              child: Container(
                color: AppColor.accent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "update_the_app".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColor.white,
                                fontWeight: FontWeight.w900),
                      ),
                      const Icon(
                        Icons.arrow_circle_right_outlined,
                        color: AppColor.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
