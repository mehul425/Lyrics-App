import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/color_scheme.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/core/dimens.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/author/author_bloc.dart';
import 'package:juna_bhajan/view/author/author_event.dart';
import 'package:juna_bhajan/view/author/author_state.dart';
import 'package:juna_bhajan/view/common/bhajan_item_view.dart';
import 'package:juna_bhajan/view/common/common_cached_network_image_view.dart';
import 'package:juna_bhajan/view/common/common_scaffold_view.dart';
import 'package:juna_bhajan/view/common/error_view.dart';
import 'package:juna_bhajan/view/common/fixed_size_progress_bar.dart';
import 'package:juna_bhajan/view/common/no_internet_view.dart';

@RoutePage(name: 'AuthorRouter')
class AuthorView extends StatelessWidget {
  final Author author;

  const AuthorView({
    required this.author,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthorBloc(
        apiRepository: context.read<ApiRepository>(),
        analyticsRepository: context.read<AnalyticsRepository>(),
      )..add(LoadAuthorDataEvent(author: author)),
      child: CommonScaffoldView(
        title: author.name,
        body: BlocBuilder<AuthorBloc, ResultState<AuthorState>>(
          builder: (context, result) {
            return result.when(
              loading: () => const FixedSizeProgressBar(height: 400),
              success: (authorState) => SingleChildScrollView(
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
                          imageUrl: authorState.author.imageUrl,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      authorState.author.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 18),
                    ),
                    if (authorState.author.bornPlace.isNotEmpty ||
                        authorState.author.bornTime.isNotEmpty)
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, right: 24, left: 24),
                        child: Text.rich(
                          TextSpan(
                            text: "${"born".tr()}: ",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 16),
                            children: [
                              if (authorState.author.bornPlace.isEmpty)
                                TextSpan(
                                  text: authorState.author.bornTime,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              if (authorState.author.bornTime.isEmpty)
                                TextSpan(
                                  text: authorState.author.bornPlace,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              if (authorState.author.bornPlace.isNotEmpty &&
                                  authorState.author.bornTime.isNotEmpty)
                                TextSpan(
                                  text:
                                      "${authorState.author.bornPlace}(${authorState.author.bornTime})",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                            ],
                          ),
                        ),
                      ),
                    if (authorState.author.nirvanaPlace.isNotEmpty ||
                        authorState.author.nirvanaTime.isNotEmpty)
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 4, right: 24, left: 24),
                        child: Text.rich(
                          TextSpan(
                            text: "${"nirvan".tr()}: ",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 16),
                            children: [
                              if (authorState.author.nirvanaPlace.isEmpty)
                                TextSpan(
                                  text: authorState.author.nirvanaTime,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              if (authorState.author.nirvanaTime.isEmpty)
                                TextSpan(
                                  text: authorState.author.nirvanaPlace,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              if (authorState.author.nirvanaPlace.isNotEmpty &&
                                  authorState.author.nirvanaTime.isNotEmpty)
                                TextSpan(
                                  text:
                                      "${authorState.author.nirvanaPlace}(${authorState.author.nirvanaTime})",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                            ],
                          ),
                        ),
                      ),
                    authorState.guruShree.maybeWhen(
                      success: (guruShree) => Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            context.router
                                .push(AuthorRouter(author: guruShree));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${"guru".tr()}: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontSize: 16),
                                ),
                                Text(
                                  guruShree.name,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      orElse: () => const SizedBox(),
                    ),
                    if (authorState.author.otherDetails != null &&
                        authorState.author.otherDetails!.isNotEmpty)
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
                              authorState.author.otherDetails!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    authorState.bhajanList.maybeWhen(
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "bhajan".tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(fontSize: 18),
                                      ),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          context.router.push(BhajanListRouter(
                                            bhajanListType:
                                                BhajanListType.author,
                                            authorId: authorState.author.id,
                                          ));
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
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .crossLightColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: bhajanList.take(5).length + 2,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    height: 1,
                                    endIndent: 16,
                                    indent: 16,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index == 0 ||
                                        bhajanList.take(5).length + 1 ==
                                            index) {
                                      return const SizedBox();
                                    } else {
                                      return BhajanItemView(
                                        bhajan: bhajanList
                                            .take(5)
                                            .toList()[index - 1],
                                        onTap: (bhajan) {
                                          context.router.push(
                                              BhajanRouter(bhajan: bhajan));
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
                      .read<AuthorBloc>()
                      .add(LoadAuthorDataEvent(author: author));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
