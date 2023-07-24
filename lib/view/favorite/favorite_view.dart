import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/data/repository/auth_repository.dart';
import 'package:juna_bhajan/view/common/bhajan_item_view.dart';
import 'package:juna_bhajan/view/common/common_scaffold_view.dart';
import 'package:juna_bhajan/view/common/empty_view.dart';
import 'package:juna_bhajan/view/common/error_view.dart';
import 'package:juna_bhajan/view/common/fixed_size_progress_bar.dart';
import 'package:juna_bhajan/view/common/no_internet_view.dart';
import 'package:juna_bhajan/view/favorite/favorite_bloc.dart';

@RoutePage(name: 'FavoriteRouter')
class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(
        apiRepository: context.read<ApiRepository>(),
        authRepository: context.read<AuthRepository>(),
        analyticsRepository: context.read<AnalyticsRepository>(),
      )..add(const LoadFavoriteBhajanListDataEvent()),
      child: CommonScaffoldView(
        showLanding: true,
        title: "favorite_bhajan".tr(),
        body: BlocBuilder<FavoriteBloc, ResultState<FavoriteState>>(
          builder: (context, result) {
            return result.when(
              loading: () => const FixedSizeProgressBar(height: 400),
              success: (data) => data.bhajanList.isEmpty
                  ? const EmptyView()
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: data.bhajanList.length,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        endIndent: 16,
                        indent: 16,
                      ),
                      itemBuilder: (context, index) => BhajanItemView(
                        bhajan: data.bhajanList[index],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        onTap: (bhajan) {
                          FocusScope.of(context).unfocus();
                          context.router.push(BhajanRouter(bhajan: bhajan));
                        },
                      ),
                    ),
              failure: (e) => ErrorView(object: e),
              noInternet: () => NoInternetView(
                onRefresh: () {
                  context
                      .read<FavoriteBloc>()
                      .add(const LoadFavoriteBhajanListDataEvent());
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
