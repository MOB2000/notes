import 'package:flutter/material.dart';
import 'package:notes/constants.dart';

class ColorPicker extends StatefulWidget {
  final Function(int) onTap;
  final int selectedIndex;

  const ColorPicker({
    Key? key,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    selectedIndex ??= widget.selectedIndex;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kColors.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(index);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 50,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: kColors[index],
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: Center(
                  child: selectedIndex == index
                      ? const Icon(Icons.done)
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
