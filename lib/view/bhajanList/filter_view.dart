import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/color_scheme.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/result.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';
import 'package:juna_bhajan/view/bhajanList/bhajan_list_bloc.dart';
import 'package:juna_bhajan/view/bhajanList/bhajan_list_event.dart';
import 'package:juna_bhajan/view/bhajanList/bhajan_list_state.dart';
import 'package:juna_bhajan/view/common/common_outline_button.dart';
import 'package:juna_bhajan/view/common/filter_dropdown.dart';

class CustomBottomAppbar extends StatelessWidget {
  final AnimationController controller;

  const CustomBottomAppbar({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return SizeTransition(
          sizeFactor: Tween<double>(begin: 0, end: 1).animate(controller),
          child: Column(
            children: [
              Expanded(
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    controller.reverse();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black12,
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.black12
                              : Colors.white24,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.black12,
                child: FilterView(controller: controller),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FilterView extends StatelessWidget {
  final AnimationController controller;

  const FilterView({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Theme.of(context).colorScheme.baseColor,
      elevation: 8,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "apply_filter".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 16),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      controller.reverse();
                    },
                    customBorder: const CircleBorder(),
                    child: Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Theme.of(context).colorScheme.filterDropDown,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
            const Divider(),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "author".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 16),
                ),
                BlocBuilder<BhajanListBloc, Result<BhajanListState>>(
                  builder: (context, result) {
                    return result.maybeWhen(
                      success: (data) => FilterDropDown<Author>(
                        list: data.authorList,
                        hint: "select".tr(),
                        value: data.author,
                        setLabel: (Author author) => author.name,
                        onChanged: (author) {
                          context
                              .read<BhajanListBloc>()
                              .add(ChangeAuthorEvent(author: author));
                        },
                      ),
                      orElse: () => const SizedBox(),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "type".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 16),
                ),
                BlocBuilder<BhajanListBloc, Result<BhajanListState>>(
                  builder: (context, result) {
                    return result.maybeWhen(
                      success: (data) => FilterDropDown<Type>(
                        list: data.typeList,
                        hint: "select".tr(),
                        value: data.type,
                        setLabel: (Type type) => type.nameGuj,
                        onChanged: (type) {
                          context
                              .read<BhajanListBloc>()
                              .add(ChangeTypeEvent(type: type));
                        },
                      ),
                      orElse: () => const SizedBox(),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "tag".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 16),
                ),
                BlocBuilder<BhajanListBloc, Result<BhajanListState>>(
                  builder: (context, result) {
                    return result.maybeWhen(
                      success: (data) => FilterDropDown<Tag>(
                        list: data.tagList,
                        hint: "select".tr(),
                        value: data.tag,
                        setLabel: (Tag tag) => tag.nameGuj,
                        onChanged: (tag) {
                          context
                              .read<BhajanListBloc>()
                              .add(ChangeTagEvent(tag: tag));
                        },
                      ),
                      orElse: () => const SizedBox(),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "god".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 16),
                ),
                BlocBuilder<BhajanListBloc, Result<BhajanListState>>(
                  builder: (context, result) {
                    return result.maybeWhen(
                      success: (data) => FilterDropDown<Related>(
                        list: data.relatedList,
                        hint: "select".tr(),
                        value: data.related,
                        setLabel: (Related related) => related.nameGuj,
                        onChanged: (related) {
                          context
                              .read<BhajanListBloc>()
                              .add(ChangeRelatedEvent(related: related));
                        },
                      ),
                      orElse: () => const SizedBox(),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "singer".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 16),
                ),
                BlocBuilder<BhajanListBloc, Result<BhajanListState>>(
                  builder: (context, result) {
                    return result.maybeWhen(
                      success: (data) => FilterDropDown<Singer>(
                        list: data.singerList,
                        hint: "select".tr(),
                        value: data.singer,
                        setLabel: (Singer singer) => singer.name,
                        onChanged: (singer) {
                          context
                              .read<BhajanListBloc>()
                              .add(ChangeSingerEvent(singer: singer));
                        },
                      ),
                      orElse: () => const SizedBox(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            CommonOutlineButton(
              label: "remove_all".tr(),
              loadMore: () {
                context.read<BhajanListBloc>().add(const ClearFilterEvent());
                controller.reverse();
              },
              padding: 0,
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}

class FilteredChipListView extends StatelessWidget {
  const FilteredChipListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: BlocBuilder<BhajanListBloc, Result<BhajanListState>>(
          builder: (context, state) {
        return state.maybeWhen(
          success: (data) => Wrap(
            alignment: WrapAlignment.end,
            verticalDirection: VerticalDirection.up,
            children: [
              data.author == null
                  ? const SizedBox()
                  : FilterChipView(
                      label: data.author!.name,
                      onTab: () {
                        context
                            .read<BhajanListBloc>()
                            .add(const ChangeAuthorEvent(author: null));
                      },
                    ),
              data.type == null
                  ? const SizedBox()
                  : FilterChipView(
                      label: data.type!.nameGuj,
                      onTab: () {
                        context
                            .read<BhajanListBloc>()
                            .add(const ChangeTypeEvent(type: null));
                      },
                    ),
              data.tag == null
                  ? const SizedBox()
                  : FilterChipView(
                      label: data.tag!.nameGuj,
                      onTab: () {
                        context
                            .read<BhajanListBloc>()
                            .add(const ChangeTagEvent(tag: null));
                      },
                    ),
              data.related == null
                  ? const SizedBox()
                  : FilterChipView(
                      label: data.related!.nameGuj,
                      onTab: () {
                        context
                            .read<BhajanListBloc>()
                            .add(const ChangeRelatedEvent(related: null));
                      },
                    ),
              data.singer == null
                  ? const SizedBox()
                  : FilterChipView(
                      label: data.singer!.name,
                      onTab: () {
                        context
                            .read<BhajanListBloc>()
                            .add(const ChangeSingerEvent(singer: null));
                      },
                    ),
            ],
          ),
          orElse: () => const SizedBox(),
        );
      }),
    );
  }
}

class FilterChipView extends StatelessWidget {
  final String label;
  final Function onTab;

  const FilterChipView({
    required this.label,
    required this.onTab,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTab();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.crossLightColor),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.only(top: 4, left: 2, bottom: 2, right: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14, color: Theme.of(context).colorScheme.baseColor),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.clear,
              size: 12,
              color: Theme.of(context).colorScheme.baseColor,
            )
          ],
        ),
      ),
    );
  }
}
