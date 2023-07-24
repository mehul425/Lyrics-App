import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:juna_bhajan/core/color_scheme.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final Function loadMore;
  final double padding;
  final double height;
  final FontWeight fontWeight;

  const CommonButton({Key? key,
    required this.label,
    required this.loadMore,
    this.padding = 16,
    this.height = kToolbarHeight,
    this.fontWeight = FontWeight.w400,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextButton(
        onPressed: () {
          loadMore();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .baseColor,
                  fontWeight: fontWeight),
            ),
            Visibility(
              visible: isLoading,
              child: SpinKitCircle(
                size: 24,
                color: Theme
                    .of(context)
                    .colorScheme
                    .baseColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
