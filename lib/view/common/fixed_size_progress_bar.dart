import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:juna_bhajan/core/color_scheme.dart';

class FixedSizeProgressBar extends StatelessWidget {
  final double height;

  const FixedSizeProgressBar({required this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SpinKitCircle(
        color: Theme.of(context).colorScheme.crossColor,
      ),
    );
  }
}
