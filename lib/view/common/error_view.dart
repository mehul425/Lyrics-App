import 'package:flutter/material.dart';
import 'package:juna_bhajan/core/dimens.dart';

class ErrorView extends StatelessWidget {
  final Object? object;

  const ErrorView({this.object, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimens.horizontalPadding,
          right: Dimens.verticalPadding,
        ),
        child: Text(
          object.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
