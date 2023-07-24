import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:juna_bhajan/core/color_scheme.dart';

class EmptyView extends StatelessWidget {
  final Object? object;

  const EmptyView({this.object, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 141,
          ),
          Icon(
            Icons.info_outline_rounded,
            size: 48,
            color: Theme.of(context).colorScheme.iconColor,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "no_details_available".tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
