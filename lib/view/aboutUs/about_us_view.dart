import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juna_bhajan/core/app_assets.dart';
import 'package:juna_bhajan/core/dimens.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/aboutUs/about_us_bloc.dart';
import 'package:juna_bhajan/view/aboutUs/about_us_event.dart';
import 'package:juna_bhajan/view/aboutUs/about_us_state.dart';
import 'package:juna_bhajan/view/common/common_scaffold_view.dart';
import 'package:juna_bhajan/view/common/error_view.dart';
import 'package:juna_bhajan/view/common/fixed_size_progress_bar.dart';
import 'package:juna_bhajan/view/common/no_internet_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage(name: 'AboutUsRouter')
class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutUsBloc(
        apiRepository: context.read<ApiRepository>(),
      )..add(const LoadAboutUsDataEvent()),
      child: CommonScaffoldView(
        title: "about_us".tr(),
        body: BlocBuilder<AboutUsBloc, ResultState<AboutUsState>>(
          builder: (context, result) {
            return result.when(
              loading: () => const FixedSizeProgressBar(height: 400),
              success: (data) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      "jay_gurudev".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 22),
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: Dimens.horizontalPadding,
                          right: Dimens.verticalPadding,
                          bottom: 6,
                          top: 6),
                      child: Column(
                        children: [
                          Text(
                            data.other.desc,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            data.other.end,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 16),
                          ),
                          if (data.other.showLink)
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: InkWell(
                                onTap: () async {
                                  context
                                      .read<AnalyticsRepository>()
                                      .logContactUsClick();
                                  await launchUrlString(
                                    data.other.link,
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                customBorder: const CircleBorder(),
                                child: SvgPicture.asset(
                                    AppAssets.icTelegram),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              failure: (e) => ErrorView(object: e),
              noInternet: () => NoInternetView(
                onRefresh: () {
                  context.read<AboutUsBloc>().add(const LoadAboutUsDataEvent());
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
