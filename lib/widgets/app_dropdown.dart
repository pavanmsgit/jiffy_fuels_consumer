import 'package:flutter/material.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    this.text = '',
  }) : super(key: key);
  final List items;
  final String text;
  final Function(Object?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey.withOpacity(0.3),
      height: ScreenSize.height(context) * 0.06,
      child: DropdownButton(
        isExpanded: true,
        iconSize: 26,
        hint: Text(text),
        underline: Container(height: 0),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
