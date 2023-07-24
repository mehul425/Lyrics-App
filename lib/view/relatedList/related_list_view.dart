import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/core/dimens.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/common/common_cached_network_image_view.dart';
import 'package:juna_bhajan/view/common/common_scaffold_view.dart';
import 'package:juna_bhajan/view/common/error_view.dart';
import 'package:juna_bhajan/view/common/fixed_size_progress_bar.dart';
import 'package:juna_bhajan/view/common/no_internet_view.dart';
import 'package:juna_bhajan/view/relatedList/related_list_bloc.dart';
import 'package:juna_bhajan/view/relatedList/related_list_event.dart';
import 'package:juna_bhajan/view/relatedList/related_list_state.dart';

@RoutePage(name: 'RelatedListRouter')
class RelatedListView extends StatelessWidget {
  const RelatedListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RelatedListBloc(apiRepository: context.read<ApiRepository>())
            ..add(const LoadRelatedListDataEvent()),
      child: CommonScaffoldView(
        title: "all_gods".tr(),
        body: BlocBuilder<RelatedListBloc, ResultState<RelatedListState>>(
          builder: (context, result) {
            return result.when(
              loading: () => const FixedSizeProgressBar(height: 400),
              success: (data) => GridView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.horizontalPadding),
                itemCount: data.relatedList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width ~/ 112,
                    childAspectRatio: 0.74),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    context.router.push(BhajanListRouter(
                      bhajanListType: BhajanListType.related,
                      relatedId: data.relatedList[index].id,
                    ));
                  },
                  child: Column(
                    children: [
                      Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: CommonCachedNetworkImageView(
                          height: 92,
                          width: 82,
                          imageUrl: data.relatedList[index].imageUrl,
                          radius: 4,
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.relatedList[index].nameGuj,
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
                      .read<RelatedListBloc>()
                      .add(const LoadRelatedListDataEvent());
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
