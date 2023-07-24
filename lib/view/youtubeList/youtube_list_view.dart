import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/model/result.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/common/empty_view.dart';
import 'package:juna_bhajan/view/common/error_view.dart';
import 'package:juna_bhajan/view/common/fixed_size_progress_bar.dart';
import 'package:juna_bhajan/view/common/youtube_item_view.dart';
import 'package:juna_bhajan/view/youtubeList/filter_view.dart';
import 'package:juna_bhajan/view/youtubeList/youtube_list_bloc.dart';
import 'package:juna_bhajan/view/youtubeList/youtube_list_event.dart';
import 'package:juna_bhajan/view/youtubeList/youtube_list_state.dart';

@RoutePage(name: 'YoutubeListRouter')
class YoutubeListView extends StatelessWidget {
  const YoutubeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YoutubeListBloc(
        apiRepository: context.read<ApiRepository>(),
        analyticsRepository: context.read<AnalyticsRepository>(),
      )..add(const LoadYoutubeListDataEvent()),
      child: const YoutubeListContentView(),
    );
  }
}

class YoutubeListContentView extends HookWidget {
  const YoutubeListContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimationController filterController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 150),
    );
    AnimationController animationController =
        useAnimationController(duration: const Duration(seconds: 0));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox(),
      ),
      body: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.axis == Axis.vertical &&
              scrollInfo.metrics.pixels <= 10) {
            animationController.animateTo(scrollInfo.metrics.pixels / 10);
            return true;
          } else {
            animationController.animateTo(1.0);
            return false;
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: [
              BlocBuilder<YoutubeListBloc, Result<YoutubeListState>>(
                builder: (context, result) {
                  return result.when(
                    loading: () => const FixedSizeProgressBar(height: 400),
                    success: (data) => data.bhajanList.isEmpty
                        ? const EmptyView()
                        : ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: kToolbarHeight),
                            itemCount: data.bhajanList.length,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              endIndent: 16,
                              indent: 16,
                            ),
                            itemBuilder: (context, index) => YoutubeItemView(
                              isExpanded: data.isExpanded,
                              tuple2: data.bhajanList[index],
                              onTap: (tuple2) {
                                context.pushRoute(
                                    BhajanRouter(bhajan: tuple2.item1));
                              },
                            ),
                          ),
                    failure: (e) => ErrorView(object: e),
                  );
                },
              ),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: kToolbarHeight,
                width: MediaQuery.of(context).size.width,
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) => PhysicalModel(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: Tween(begin: 0.0, end: 4.0)
                        .animate(animationController)
                        .value,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Tween(begin: 0.0, end: 18.0)
                            .animate(animationController)
                            .value),
                        bottomRight: Radius.circular(
                            Tween(begin: 0.0, end: 18.0)
                                .animate(animationController)
                                .value)),
                    child: child,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: InkWell(
                          onTap: () {
                            context.router.pop();
                          },
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "all_youtube_bhajan".tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<YoutubeListBloc>()
                              .add(const ToggleExpandedEvent());
                        },
                        customBorder: const CircleBorder(),
                        child: BlocBuilder<YoutubeListBloc,
                            Result<YoutubeListState>>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => const SizedBox(),
                              success: (data) => Icon(
                                data.isExpanded
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            filterController.isCompleted
                                ? filterController.reverse()
                                : filterController.forward();
                          },
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.filter_list_alt),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomBottomAppbar(controller: filterController),
              ),
              SizeTransition(
                sizeFactor:
                    Tween<double>(begin: 1, end: 0).animate(filterController),
                child: const Align(
                    alignment: Alignment.bottomRight,
                    child: FilteredChipListView()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
