import 'package:flutter/material.dart';

abstract class DropDownItem {
  String text();
}

class DropDownButtonWidget<G extends DropDownItem> extends StatelessWidget {
  final List<G> items;
  final ValueChanged<G?>? onChanged;
  final String hint;
  final G? value;
  const DropDownButtonWidget({
    required this.items,
    required this.onChanged,
    required this.value,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    var i = items
        .map(
          (i) => DropdownMenuItem<G>(
            value: i,
            child: new Text(
              "${i.text()}",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        )
        .toList();


    return DropdownButton<G>(
      value: value,
      hint: Text(hint),
      items: i,
      isExpanded: true,
      onChanged: onChanged, //widget.onChanged?.call(newValue.result);
    );
  }

}
