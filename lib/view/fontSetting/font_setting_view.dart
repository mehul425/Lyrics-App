import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juna_bhajan/core/color_scheme.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/view/common/common_scaffold_view.dart';
import 'package:juna_bhajan/view/setting/setting_bloc.dart';
import 'package:juna_bhajan/view/setting/setting_event.dart';
import 'package:juna_bhajan/view/setting/setting_state.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

@RoutePage(name: 'FontSettingRouter')
class FontSettingView extends StatelessWidget {
  const FontSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldView(
      title: "font_setting".tr(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: InkWell(
            onTap: () {
              context.read<SettingBloc>().add(const SaveFontSettingDataEvent());
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("font_Setting_saved".tr())));
            },
            customBorder: const CircleBorder(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.done,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 6, left: 16, right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              // height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.crossLightColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: BlocBuilder<SettingBloc, SettingState>(
                  buildWhen: (previous, current) {
                return previous.fontFamily != current.fontFamily ||
                    previous.fontWeight != current.fontWeight ||
                    previous.fontBrightness != current.fontBrightness ||
                    previous.fontSize != current.fontSize;
              }, builder: (context, state) {
                return Text(
                  "sakhi_text".tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: state.fontSize,
                      color: Theme.of(context)
                          .colorScheme
                          .crossColor
                          .withOpacity(state.fontBrightness / 10),
                      fontWeight: FontWeight.values[state.fontWeight],
                      fontFamily:
                          GoogleFonts.getFont(state.fontFamily).fontFamily),
                );
              }),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "font_size".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 18),
              ),
            ),
            BlocBuilder<SettingBloc, SettingState>(
              buildWhen: (previous, current) =>
                  previous.fontSize != current.fontSize,
              builder: (context, state) {
                return SfSlider(
                  min: 16,
                  max: 22,
                  value: state.fontSize,
                  interval: 1,
                  showTicks: false,
                  showLabels: false,
                  enableTooltip: false,
                  activeColor: Theme.of(context).colorScheme.crossColor,
                  inactiveColor: Theme.of(context).colorScheme.crossLightColor,
                  onChanged: (dynamic value) {
                    context
                        .read<SettingBloc>()
                        .add(ChangeFontSizeEvent(fontSize: value));
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "font_brightness".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 18),
              ),
            ),
            BlocBuilder<SettingBloc, SettingState>(
              buildWhen: (previous, current) =>
                  previous.fontBrightness != current.fontBrightness,
              builder: (context, state) {
                return SfSlider(
                  min: 4,
                  max: 10,
                  value: state.fontBrightness,
                  interval: 1,
                  showTicks: false,
                  showLabels: false,
                  enableTooltip: false,
                  activeColor: Theme.of(context).colorScheme.crossColor,
                  inactiveColor: Theme.of(context).colorScheme.crossLightColor,
                  onChanged: (dynamic value) {
                    context
                        .read<SettingBloc>()
                        .add(ChangeFontBrightnessEvent(fontBrightness: value));
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "font_weight".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 18),
              ),
            ),
            BlocBuilder<SettingBloc, SettingState>(
              buildWhen: (previous, current) =>
                  previous.fontWeight != current.fontWeight,
              builder: (context, state) {
                return SfSlider(
                  min: 0,
                  max: 8,
                  value: state.fontWeight,
                  interval: 1,
                  showTicks: false,
                  showLabels: false,
                  enableTooltip: false,
                  activeColor: Theme.of(context).colorScheme.crossColor,
                  inactiveColor: Theme.of(context).colorScheme.crossLightColor,
                  onChanged: (dynamic value) {
                    context
                        .read<SettingBloc>()
                        .add(ChangeFontWeightEvent(fontWeight: value));
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ExpandableNotifier(
                initialExpanded: true,
                child: Expandable(
                  collapsed: const FontFamilyCollapsedView(),
                  expanded: Column(
                    children: [
                      const FontFamilyCollapsedView(),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        children: [
                          ...(context.read<ProjectType>() ==
                                      ProjectType.junaBhajan
                                  ? gujaratiFontFamilyList
                                  : hindiFontFamilyList)
                              .map((e) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.item2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                fontFamily:
                                                    GoogleFonts.getFont(e.item1)
                                                        .fontFamily),
                                      ),
                                      BlocBuilder<SettingBloc, SettingState>(
                                        buildWhen: (previous, current) =>
                                            previous.fontFamily !=
                                            current.fontFamily,
                                        builder: (context, state) {
                                          return Radio<String>(
                                            value: e.item1,
                                            activeColor: Theme.of(context)
                                                .colorScheme
                                                .crossColor,
                                            groupValue: state.fontFamily,
                                            onChanged: (value) {
                                              context.read<SettingBloc>().add(
                                                  ChangeFontFamilyEvent(
                                                      fontFamily: value!));
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FontFamilyCollapsedView extends StatelessWidget {
  const FontFamilyCollapsedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "font_family".tr(),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 18),
        ),
        Builder(builder: (context) {
          var expandableController =
              ExpandableController.of(context, required: true);
          return InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              expandableController.toggle();
            },
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                expandableController!.expanded
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                color: Theme.of(context).colorScheme.crossLightColor,
                size: 32,
              ),
            ),
          );
        })
      ],
    );
  }
}
