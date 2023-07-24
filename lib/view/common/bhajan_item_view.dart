import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';

class BhajanItemView extends StatelessWidget {
  final Bhajan bhajan;
  final Function(Bhajan) onTap;
  final FontWeight fontWeight;
  final double fontSize;

  const BhajanItemView({
    required this.bhajan,
    required this.onTap,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 14,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(bhajan);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              bhajan.nameGuj,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
            ),
            if(bhajan.youtube!.isNotEmpty)
            const Icon(
              CupertinoIcons.play_rectangle,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
