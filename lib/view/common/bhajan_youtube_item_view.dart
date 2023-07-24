import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/app_colors.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/extension/other_extension.dart';
import 'package:juna_bhajan/view/common/common_cached_network_image_view.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BhajanYoutubeItemView extends StatelessWidget {
  final Tuple2<Bhajan, Youtube> tuple2;

  const BhajanYoutubeItemView({
    required this.tuple2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<AnalyticsRepository>().logYoutubeVideo(tuple2);
        if (!await launchUrlString(
          "https://www.youtube.com/watch?v=${tuple2.item2.videoId}",
          mode: LaunchMode.externalApplication,
        )) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("download_youtube_app".tr())));
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 14),
        child: ExpandableNotifier(
          initialExpanded: false,
          child: Expandable(
            collapsed: CollapsedTextView(name: tuple2.item2.name),
            expanded: Column(
              children: [
                CollapsedTextView(name: tuple2.item2.name),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CommonCachedNetworkImageView(
                          height: 60,
                          width: 110,
                          radius: 0,
                          imageUrl: tuple2.item2.image,
                          shape: BoxShape.rectangle,
                        ),
                        Container(
                          height: 60,
                          width: 110,
                          color: AppColor.blackLight.withOpacity(0.2),
                        ),
                        Icon(
                          CupertinoIcons.play_circle,
                          size: 48,
                          color: AppColor.white.withOpacity(0.8),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tuple2.item1.nameGuj,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 13),
                          ),
                          Row(
                            children: [
                              Text(
                                tuple2.item2.duration.toHhMmSs(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 13),
                              ),
                              // const Spacer(),
                              // Text(
                              //   tuple2.item2.channelName,
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .bodyLarge!
                              //       .copyWith(fontSize: 13),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CollapsedTextView extends StatelessWidget {
  final String name;

  const CollapsedTextView({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        InkWell(
          onTap: () {
            ExpandableController.of(context)?.toggle();
          },
          customBorder: const CircleBorder(),
          child: ExpandableIcon(
            theme: const ExpandableThemeData(
              expandIcon: Icons.arrow_drop_down,
              collapseIcon: Icons.arrow_drop_up,
              iconPadding: EdgeInsets.all(10),
              iconSize: 24,
              iconRotationAngle: -pi / 4,
            ),
          ),
        ),
      ],
    );
  }
}
