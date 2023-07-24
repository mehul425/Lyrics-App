import 'package:flutter/material.dart';
import 'package:juna_bhajan/core/color_scheme.dart';

class FilterDropDown<T> extends StatelessWidget {
  final List<T> list;
  final T? value;
  final String hint;
  final String Function(T) setLabel;
  final Function(T?) onChanged;
  final bool isLastItem;
  final double marginTop;

  const FilterDropDown({
    required this.list,
    required this.value,
    required this.hint,
    required this.setLabel,
    required this.onChanged,
    this.isLastItem = false,
    this.marginTop = 5,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      margin: isLastItem
          ? EdgeInsets.only(top: marginTop, bottom: 5)
          : EdgeInsets.only(right: 4, top: marginTop, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        color: Theme.of(context).colorScheme.filterDropDown,
      ),
      child: DropdownButton<T>(
        isExpanded: false,
        isDense: true,
        value: value,
        onChanged: onChanged,
        dropdownColor: Theme.of(context).colorScheme.filterDropDown,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 11, color: Theme.of(context).colorScheme.baseLightColor),
        iconEnabledColor: Theme.of(context).colorScheme.baseLightColor,
        iconSize: 18,
        hint: Text(
          hint,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14,
              color: Theme.of(context).colorScheme.baseLightColor),
        ),
        underline: const SizedBox(),
        selectedItemBuilder: (context) => list
            .map((data) => Text(
                  setLabel(data),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.baseLightColor),
                ))
            .toList(),
        items: list
            .map((data) => DropdownMenuItem<T>(
                  value: data,
                  child: Text(
                    setLabel(data),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.baseLightColor),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
