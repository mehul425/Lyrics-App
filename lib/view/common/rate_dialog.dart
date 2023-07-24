import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:juna_bhajan/core/app_colors.dart';
import 'package:store_redirect/store_redirect.dart';

class RateDialog extends StatelessWidget {
  const RateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "give_rating".tr(),
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 24),
          Text(
            "rating_text".tr(),
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 18),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: AppColor.accent,
                size: 28,
              ),
              SizedBox(width: 4),
              Icon(
                Icons.star,
                color: AppColor.accent,
                size: 28,
              ),
              SizedBox(width: 4),
              Icon(
                Icons.star,
                color: AppColor.accent,
                size: 28,
              ),
              SizedBox(width: 4),
              Icon(
                Icons.star,
                color: AppColor.accent,
                size: 28,
              ),
              SizedBox(width: 4),
              Icon(
                Icons.star_half,
                color: AppColor.accent,
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 18),
          InkWell(
            onTap: () {
              StoreRedirect.redirect();
              context.router.pop(true);
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.accent,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "give_rating".tr(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColor.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: () {
              context.router.pop(false);
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "not_now".tr(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColor.accent,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
