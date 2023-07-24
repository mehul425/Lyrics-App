import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:juna_bhajan/core/app_assets.dart';
import 'package:juna_bhajan/core/app_colors.dart';
import 'package:juna_bhajan/core/color_scheme.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/core/dimens.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/model/user.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/view/common/common_scaffold_view.dart';
import 'package:juna_bhajan/view/setting/setting_bloc.dart';
import 'package:juna_bhajan/view/setting/setting_event.dart';
import 'package:juna_bhajan/view/setting/setting_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

@RoutePage(name: 'SettingRouter')
class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: CommonScaffoldView(
        title: "setting".tr(),
        actions: [
          BlocSelector<SettingBloc, SettingState, UserData?>(
            selector: (state) => state.user,
            builder: (context, state) {
              return state == null
                  ? const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: SizedBox(width: 40),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<SettingBloc>()
                              .add(const GoogleLoginOutSettingDataEvent());
                        },
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.logout,
                          ),
                        ),
                      ),
                    );
            },
          )
        ],
        body: Padding(
          padding: const EdgeInsets.only(
              left: Dimens.horizontalPadding,
              right: Dimens.verticalPadding,
              bottom: 6,
              top: 6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                const ProfileView(),
                const SizedBox(height: 24),
                Card(
                  elevation: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.color_lens_outlined),
                                const SizedBox(width: 12),
                                Text(
                                  "dark_theme".tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
                              child: BlocBuilder<SettingBloc, SettingState>(
                                  buildWhen: (previous, current) =>
                                      previous.themeMode != current.themeMode,
                                  builder: (context, state) {
                                    return Switch(
                                      activeColor: AppColor.accent,
                                      value: state.themeMode == ThemeMode.dark,
                                      onChanged: (value) {
                                        context.read<SettingBloc>().add(
                                              ChangeThemeDataEvent(
                                                themeMode: value
                                                    ? ThemeMode.dark
                                                    : ThemeMode.light,
                                              ),
                                            );
                                      },
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Divider(height: 1),
                      BlocSelector<SettingBloc, SettingState, UserData?>(
                        selector: (state) => state.user,
                        builder: (context, state) {
                          return state == null
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.router
                                            .push(const FavoriteRouter());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(CupertinoIcons
                                                    .square_favorites_alt),
                                                const SizedBox(width: 12),
                                                Text(
                                                  "favorite_bhajan".tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(height: 1),
                                  ],
                                );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<SettingBloc>()
                              .add(const LoadInitialSettingDataEvent());
                          context.router.push(const FontSettingRouter());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(CupertinoIcons.settings),
                                  const SizedBox(width: 12),
                                  Text(
                                    "font_setting".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: 18),
                                  ),
                                ],
                              ),
                              const Icon(Icons.keyboard_arrow_right_rounded),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      InkWell(
                        onTap: () {
                          context.router.push(const AboutUsRouter());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(CupertinoIcons.info),
                                  const SizedBox(width: 12),
                                  Text(
                                    "about_us".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: 18),
                                  ),
                                ],
                              ),
                              const Icon(Icons.keyboard_arrow_right_rounded),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      InkWell(
                        onTap: () {
                          context
                              .read<AnalyticsRepository>()
                              .logOtherAppClick();
                          if (context.read<ProjectType>() ==
                              ProjectType.junaBhajan) {
                            StoreRedirect.redirect(
                                androidAppId: "com.delta.hindi_bhajan");
                          } else {
                            StoreRedirect.redirect(
                                androidAppId: "com.delta.juna_bhajan");
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    context.read<ProjectType>() ==
                                            ProjectType.junaBhajan
                                        ? AppAssets.icHindiBhajan
                                        : AppAssets.icJunaBhajan,
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "other_app".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: 18),
                                  ),
                                ],
                              ),
                              const Icon(Icons.keyboard_arrow_right_rounded),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      InkWell(
                        onTap: () {
                          context.read<AnalyticsRepository>().logRateUsClick();
                          StoreRedirect.redirect();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(CupertinoIcons.star),
                                  const SizedBox(width: 12),
                                  Text(
                                    "give_rating".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: 18),
                                  ),
                                ],
                              ),
                              const Icon(Icons.keyboard_arrow_right_rounded),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      InkWell(
                        onTap: () {
                          context.read<AnalyticsRepository>().logShareClick();

                          if (context.read<ProjectType>() ==
                              ProjectType.junaBhajan) {
                            Share.share(
                                "${"share_text".tr()} https://play.google.com/store/apps/details?id=com.delta.juna_bhajan");
                          } else {
                            Share.share(
                                "${"share_text".tr()} https://play.google.com/store/apps/details?id=com.delta.hindi_bhajan");
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.share_outlined),
                                  const SizedBox(width: 12),
                                  Text(
                                    "share_it".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: 18),
                                  ),
                                ],
                              ),
                              const Icon(Icons.keyboard_arrow_right_rounded),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${"app_version".tr()} : ",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 16),
                    ),
                    BlocBuilder<SettingBloc, SettingState>(
                      buildWhen: (previous, current) =>
                          previous.appVersionName != current.appVersionName,
                      builder: (context, state) => Text(
                        "${state.appVersionName} (${state.currentAppVersion})",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) =>
          previous.user != current.user ||
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        return state.user == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      FontAwesomeIcons.faceSmile,
                      size: 48,
                      color: AppColor.accent,
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: state.isLoading
                        ? null
                        : () {
                            context
                                .read<SettingBloc>()
                                .add(const GoogleLoginSettingDataEvent());
                          },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "login".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 18),
                          ),
                          const SizedBox(width: 18),
                          state.isLoading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .crossColor,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.login_rounded),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    imageUrl: state.user!.imageUrl ?? "",
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, e) => Container(
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: state.user?.name != null
                          ? Text(
                              state.user!.name![0].toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontSize: 46),
                            )
                          : const Icon(
                              FontAwesomeIcons.faceSmile,
                              size: 48,
                              color: AppColor.accent,
                            ),
                    ),
                    placeholder: (context, url) => Container(
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: state.user?.name != null
                          ? Text(
                              state.user!.name![0].toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontSize: 46),
                            )
                          : const Icon(
                              FontAwesomeIcons.faceSmile,
                              size: 48,
                              color: AppColor.accent,
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      state.user!.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
