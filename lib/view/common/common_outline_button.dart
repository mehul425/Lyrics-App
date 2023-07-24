import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:juna_bhajan/core/color_scheme.dart';

class CommonOutlineButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final Function loadMore;
  final double padding;
  final double height;

  const CommonOutlineButton({
    Key? key,
    required this.label,
    required this.loadMore,
    this.padding = 16,
    this.isLoading = false,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: OutlinedButton(
        onPressed: () {
          loadMore();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            Visibility(
              visible: isLoading,
              child: SpinKitCircle(
                size: 24,
                color: Theme.of(context).colorScheme.crossLightColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
