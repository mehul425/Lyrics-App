import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juna_bhajan/core/color_scheme.dart';
import 'package:juna_bhajan/core/dimens.dart';

class NoInternetView extends StatelessWidget {
  final Function() onRefresh;

  const NoInternetView({
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimens.horizontalPadding,
          right: Dimens.verticalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.wifi_exclamationmark,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              "No Internet Connection...",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: onRefresh,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Re-Try",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall,
                    ),
                    const SizedBox(width: 18),
                    const Icon(Icons.refresh_outlined),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
