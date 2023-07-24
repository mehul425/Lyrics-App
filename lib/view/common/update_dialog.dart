import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/app_colors.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:store_redirect/store_redirect.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "app_update".tr(),
              style:
                  Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 24),
            Text(
              "app_update_text".tr(),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 18),
            InkWell(
              onTap: () {
                context.read<AnalyticsRepository>().logForceAppUpdate();
                StoreRedirect.redirect();
              },
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
                      "update_app".tr(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColor.white,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
