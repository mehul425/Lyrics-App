import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/dimens.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/common/common_cached_network_image_view.dart';
import 'package:juna_bhajan/view/common/common_scaffold_view.dart';
import 'package:juna_bhajan/view/common/error_view.dart';
import 'package:juna_bhajan/view/common/fixed_size_progress_bar.dart';
import 'package:juna_bhajan/view/common/no_internet_view.dart';
import 'package:juna_bhajan/view/singerList/singer_list_bloc.dart';
import 'package:juna_bhajan/view/singerList/singer_list_event.dart';
import 'package:juna_bhajan/view/singerList/singer_list_state.dart';

@RoutePage(name: 'SingerListRouter')
class SingerListView extends StatelessWidget {
  const SingerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SingerListBloc(apiRepository: context.read<ApiRepository>())
            ..add(const LoadSingerListDataEvent()),
      child: CommonScaffoldView(
        title: "all_singer".tr(),
        body: BlocBuilder<SingerListBloc, ResultState<SingerListState>>(
          builder: (context, result) {
            return result.when(
              loading: () => const FixedSizeProgressBar(height: 400),
              success: (data) => GridView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.horizontalPadding),
                itemCount: data.singerList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width ~/
                      (Dimens.imageSize + 18),
                  childAspectRatio: 0.74,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    context.router
                        .push(SingerRouter(singer: data.singerList[index]));
                  },
                  child: Column(
                    children: [
                      Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimens.imageSize / 2))),
                        child: CommonCachedNetworkImageView(
                          imageUrl: data.singerList[index].imageUrl,
                          height: Dimens.imageSize,
                          width: Dimens.imageSize,
                          radius: Dimens.imageSize / 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.singerList[index].name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
              ),
              failure: (e) => ErrorView(object: e),
              noInternet: () => NoInternetView(
                onRefresh: () {
                  context
                      .read<SingerListBloc>()
                      .add(const LoadSingerListDataEvent());
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
