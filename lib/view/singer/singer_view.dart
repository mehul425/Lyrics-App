import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/dimens.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/common/common_cached_network_image_view.dart';
import 'package:juna_bhajan/view/common/common_scaffold_view.dart';
import 'package:juna_bhajan/view/common/error_view.dart';
import 'package:juna_bhajan/view/common/fixed_size_progress_bar.dart';
import 'package:juna_bhajan/view/common/no_internet_view.dart';
import 'package:juna_bhajan/view/common/youtube_item_view.dart';
import 'package:juna_bhajan/view/singer/singer_bloc.dart';
import 'package:juna_bhajan/view/singer/singer_event.dart';
import 'package:juna_bhajan/view/singer/singer_state.dart';

@RoutePage(name: 'SingerRouter')
class SingerView extends StatelessWidget {
  final Singer singer;

  const SingerView({
    required this.singer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingerBloc(
        apiRepository: context.read<ApiRepository>(),
        analyticsRepository: context.read<AnalyticsRepository>(),
      )..add(LoadSingerDataEvent(singer: singer)),
      child: CommonScaffoldView(
        title: singer.name,
        body: BlocBuilder<SingerBloc, ResultState<SingerState>>(
          builder: (context, result) {
            return result.when(
              loading: () => const FixedSizeProgressBar(height: 400),
              success: (singerState) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonCachedNetworkImageView(
                          height: Dimens.imageSize,
                          width: Dimens.imageSize,
                          radius: Dimens.imageSize / 2,
                          imageUrl: singerState.singer.imageUrl,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      singerState.singer.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 18),
                    ),
                    // if (singerState.singer.bornPlace.isNotEmpty ||
                    //     singerState.singer.bornTime.isNotEmpty)
                    //   Padding(
                    //     padding:
                    //         const EdgeInsets.only(top: 8, right: 24, left: 24),
                    //     child: Text.rich(
                    //       TextSpan(
                    //         text: "${"born".tr()}: ",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .titleSmall!
                    //             .copyWith(fontSize: 16),
                    //         children: [
                    //           if (singerState.singer.bornPlace.isEmpty)
                    //             TextSpan(
                    //               text: singerState.singer.bornTime,
                    //               style: Theme.of(context).textTheme.titleMedium,
                    //             ),
                    //           if (singerState.singer.bornTime.isEmpty)
                    //             TextSpan(
                    //               text: singerState.singer.bornPlace,
                    //               style: Theme.of(context).textTheme.titleMedium,
                    //             ),
                    //           if (singerState.singer.bornPlace.isNotEmpty &&
                    //               singerState.singer.bornTime.isNotEmpty)
                    //             TextSpan(
                    //               text:
                    //                   "${singerState.singer.bornPlace}(${singerState.singer.bornTime})",
                    //               style: Theme.of(context).textTheme.titleMedium,
                    //             ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // if (singerState.singer.nirvanaPlace.isNotEmpty ||
                    //     singerState.singer.nirvanaTime.isNotEmpty)
                    //   Padding(
                    //     padding:
                    //         const EdgeInsets.only(top: 4, right: 24, left: 24),
                    //     child: Text.rich(
                    //       TextSpan(
                    //         text: "${"nirvan".tr()}: ",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .titleSmall!
                    //             .copyWith(fontSize: 16),
                    //         children: [
                    //           if (singerState.singer.nirvanaPlace.isEmpty)
                    //             TextSpan(
                    //               text: singerState.singer.nirvanaTime,
                    //               style: Theme.of(context).textTheme.titleMedium,
                    //             ),
                    //           if (singerState.singer.nirvanaTime.isEmpty)
                    //             TextSpan(
                    //               text: singerState.singer.nirvanaPlace,
                    //               style: Theme.of(context).textTheme.titleMedium,
                    //             ),
                    //           if (singerState.singer.nirvanaPlace.isNotEmpty &&
                    //               singerState.singer.nirvanaTime.isNotEmpty)
                    //             TextSpan(
                    //               text:
                    //                   "${singerState.singer.nirvanaPlace}(${singerState.singer.nirvanaTime})",
                    //               style: Theme.of(context).textTheme.titleMedium,
                    //             ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    if (singerState.singer.otherDetails != null &&
                        singerState.singer.otherDetails!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 22,
                            left: Dimens.horizontalPadding,
                            right: Dimens.horizontalPadding),
                        child: Column(
                          children: [
                            Text(
                              ": ${"introduction".tr()} :",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              singerState.singer.otherDetails!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    singerState.bhajanList.maybeWhen(
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
                                      return YoutubeItemView(
                                        tuple2: bhajanList[index - 1],
                                        onTap: (tuple2) {
                                          context.pushRoute(BhajanRouter(
                                              bhajan: tuple2.item1));
                                        },
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                      orElse: () => const SizedBox(),
                    ),
                    const SizedBox(height: 16)
                  ],
                ),
              ),
              failure: (e) => ErrorView(object: e),
              noInternet: () => NoInternetView(
                onRefresh: () {
                  context
                      .read<SingerBloc>()
                      .add(LoadSingerDataEvent(singer: singer));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
