import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juna_bhajan/core/color_scheme.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/data/repository/auth_repository.dart';
import 'package:juna_bhajan/view/bhajan/bhajan_bloc.dart';
import 'package:juna_bhajan/view/bhajan/bhajan_event.dart';
import 'package:juna_bhajan/view/bhajan/bhajan_state.dart';
import 'package:juna_bhajan/view/common/bhajan_youtube_item_view.dart';
import 'package:juna_bhajan/view/common/common_cached_network_image_view.dart';
import 'package:juna_bhajan/view/common/common_scaffold_view.dart';
import 'package:juna_bhajan/view/common/error_view.dart';
import 'package:juna_bhajan/view/common/fixed_size_progress_bar.dart';
import 'package:juna_bhajan/view/common/no_internet_view.dart';
import 'package:juna_bhajan/view/setting/setting_bloc.dart';
import 'package:juna_bhajan/view/setting/setting_state.dart';
import 'package:tuple/tuple.dart';

@RoutePage(name: 'BhajanRouter')
class BhajanView extends StatelessWidget {
  final Bhajan bhajan;

  const BhajanView({
    required this.bhajan,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BhajanBloc(
        apiRepository: context.read<ApiRepository>(),
        authRepository: context.read<AuthRepository>(),
        analyticsRepository: context.read<AnalyticsRepository>(),
      )..add(LoadBhajanDataEvent(bhajan: bhajan)),
      child: CommonScaffoldView(
        title: bhajan.nameGuj,
        actions: [
          BlocSelector<BhajanBloc, ResultState<BhajanState>, bool?>(
            selector: (state) => state.maybeMap(
              orElse: () => null,
              success: (value) => value.data.isFavorite,
            ),
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
                          context.read<BhajanBloc>().add(
                              BhajanAddOrRemoveFavoriteEvent(isAdd: !state));
                        },
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(state
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded),
                        ),
                      ),
                    );
            },
          ),
        ],
        body: BlocBuilder<BhajanBloc, ResultState<BhajanState>>(
          builder: (context, result) {
            return result.when(
              loading: () => const FixedSizeProgressBar(height: 400),
              success: (bhajanState) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 24),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                Theme.of(context).colorScheme.crossLightColor,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: BlocBuilder<SettingBloc, SettingState>(
                        buildWhen: (previous, current) {
                          return previous.fontFamily != current.fontFamily ||
                              previous.fontWeight != current.fontWeight ||
                              previous.fontBrightness !=
                                  current.fontBrightness ||
                              previous.fontSize != current.fontSize;
                        },
                        builder: (context, fontState) {
                          return Text(
                            bhajanState.bhajan.bhajan,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize: fontState.fontSize,
                                    color:
                                        Theme.of(context)
                                            .colorScheme
                                            .crossColor
                                            .withOpacity(
                                                fontState.fontBrightness / 10),
                                    fontWeight:
                                        FontWeight.values[fontState.fontWeight],
                                    fontFamily: GoogleFonts.getFont(
                                            fontState.fontFamily)
                                        .fontFamily),
                          );
                        },
                      ),
                    ),
                    bhajanState.author.maybeWhen(
                      success: (author) => Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            context.router.push(AuthorRouter(author: author));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                CommonCachedNetworkImageView(
                                  height: 50,
                                  width: 50,
                                  radius: 25,
                                  imageUrl: author.imageUrl,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  author.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      orElse: () => const SizedBox(),
                    ),
                    bhajanState.youtubeList.maybeWhen(
                      loading: () => const FixedSizeProgressBar(height: 200),
                      success: (bhajanList) => bhajanList.isEmpty
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 22,
                                    left: 16,
                                    right: 16,
                                  ),
                                  child: Text(
                                    "youtube_bhajan".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: bhajanList.length + 2,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    height: 1,
                                    endIndent: 16,
                                    indent: 16,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index == 0 ||
                                        bhajanList.length + 1 == index) {
                                      return const SizedBox();
                                    } else {
                                      return BhajanYoutubeItemView(
                                          tuple2: Tuple2(
                                        bhajan,
                                        bhajanList[index - 1],
                                      ));
                                    }
                                  },
                                )
                              ],
                            ),
                      orElse: () => const SizedBox(),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
              failure: (e) => ErrorView(object: e),
              noInternet: () => NoInternetView(
                onRefresh: () {
                  context
                      .read<BhajanBloc>()
                      .add(LoadBhajanDataEvent(bhajan: bhajan));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
