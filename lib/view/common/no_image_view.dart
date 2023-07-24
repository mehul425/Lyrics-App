import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:juna_bhajan/core/color_scheme.dart';
import 'package:juna_bhajan/core/dimens.dart';

class NoImageView extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const NoImageView({
    Key? key,
    this.height = Dimens.imageSize,
    this.width = Dimens.imageSize,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.baseColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      alignment: Alignment.center,
      child: Text(
        "no_image_available".tr(),
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
