import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juna_bhajan/core/color_scheme.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/model/result.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/bhajanList/bhajan_list_bloc.dart';
import 'package:juna_bhajan/view/bhajanList/bhajan_list_event.dart';
import 'package:juna_bhajan/view/bhajanList/bhajan_list_state.dart';
import 'package:juna_bhajan/view/bhajanList/filter_view.dart';
import 'package:juna_bhajan/view/common/bhajan_item_view.dart';
import 'package:juna_bhajan/view/common/empty_view.dart';
import 'package:juna_bhajan/view/common/error_view.dart';
import 'package:juna_bhajan/view/common/fixed_size_progress_bar.dart';

@RoutePage(name: 'BhajanListRouter')
class BhajanListView extends StatelessWidget {
  final BhajanListType? bhajanListType;
  final int? typeId;
  final int? tagId;
  final String? authorId;
  final String? relatedId;

  const BhajanListView({
    this.bhajanListType,
    this.typeId,
    this.tagId,
    this.authorId,
    this.relatedId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BhajanListBloc(
        apiRepository: context.read<ApiRepository>(),
        analyticsRepository: context.read<AnalyticsRepository>(),
      )..add(LoadBhajanListDataEvent(
          bhajanListType: bhajanListType,
          authorId: authorId,
          relatedId: relatedId,
          typeId: typeId,
          tagId: tagId,
        )),
      child: const BhajanListContentView(),
    );
  }
}

class BhajanListContentView extends HookWidget {
  const BhajanListContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimationController filterController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 150),
    );
    AnimationController animationController =
        useAnimationController(duration: const Duration(seconds: 0));
    TextEditingController textEditingController = useTextEditingController();
    useEffect(() {
      textEditingController.addListener(() {
        context
            .read<BhajanListBloc>()
            .add(SearchTextChangeEvent(text: textEditingController.text));
      });
      return null;
    }, [textEditingController]);
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
              BlocBuilder<BhajanListBloc, Result<BhajanListState>>(
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
                            itemBuilder: (context, index) => BhajanItemView(
                              bhajan: data.bhajanList[index].item1,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              onTap: (bhajan) {
                                FocusScope.of(context).unfocus();
                                context.router
                                    .push(BhajanRouter(bhajan: bhajan));
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
                        child: BlocBuilder<BhajanListBloc,
                                Result<BhajanListState>>(
                            builder: (context, result) {
                          return InkWell(
                            onTap: () {
                              result.maybeWhen(
                                success: (data) {
                                  if (data.isSearchActive) {
                                    textEditingController.text = "";
                                    context
                                        .read<BhajanListBloc>()
                                        .add(const ToggleSearchEvent());
                                  } else {
                                    context.router.pop();
                                  }
                                },
                                orElse: () {
                                  context.router.pop();
                                },
                              );
                            },
                            customBorder: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back),
                            ),
                          );
                        }),
                      ),
                      Expanded(
                        child: BlocBuilder<BhajanListBloc,
                                Result<BhajanListState>>(
                            builder: (context, result) {
                          return result.maybeWhen(
                            success: (data) => data.isSearchActive
                                ? TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "write_here".tr(),
                                      isDense: true,
                                      filled: true,
                                      hintStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      suffixIconConstraints:
                                          BoxConstraints.tight(
                                              const Size(36, 20)),
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          textEditingController.text = "";
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          size: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .crossColor,
                                        ),
                                      ),
                                    ),
                                    autofocus: false,
                                    controller: textEditingController,
                                    onSubmitted: (value) {
                                      if (value.isNotEmpty) {
                                        context
                                            .read<AnalyticsRepository>()
                                            .logSearch(value);
                                      }
                                    },
                                  )
                                : Text(
                                    "all_bhajan".tr(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                            orElse: () => Text(
                              "all_bhajan".tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          );
                        }),
                      ),
                      BlocBuilder<BhajanListBloc, Result<BhajanListState>>(
                          builder: (context, result) {
                        return result.maybeWhen(
                          success: (data) => Visibility(
                            visible: !data.isSearchActive,
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<BhajanListBloc>()
                                    .add(const ToggleSearchEvent());
                              },
                              customBorder: const CircleBorder(),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.search),
                              ),
                            ),
                          ),
                          orElse: () => const SizedBox(),
                        );
                      }),
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
