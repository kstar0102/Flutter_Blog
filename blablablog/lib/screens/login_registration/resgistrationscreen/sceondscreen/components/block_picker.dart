/// Blocky Color Picker
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:blabloglucy/domain/auth/models/colors.dart';

/// Child widget for layout builder.
typedef PickerItem = Widget Function(ColorsModel color);

/// Customize the layout.
typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, List<ColorsModel> colors, PickerItem child);

/// Customize the item shape.
typedef PickerItemBuilder = Widget Function(
  ColorsModel color,
  bool isCurrentColor,
  void Function() changeColor,
);

// Provide a list of colors for block color picker.

// Provide a layout for [BlockPicker].
Widget _defaultLayoutBuilder(
  BuildContext context,
  List<ColorsModel> colors,
  PickerItem child,
) {
  Orientation orientation = MediaQuery.of(context).orientation;

  return SizedBox(
    width: 280,
    height: orientation == Orientation.portrait ? 320 : 200,
    child: GridView.count(
      crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [
        for (ColorsModel color in colors) child(color),
      ],
    ),
  );
}

// Provide a shape for [BlockPicker].
Widget _defaultItemBuilder(
    ColorsModel colors, bool isCurrentColor, void Function() changeColor) {
  final Color color = rgbColor(colors.colorHex);
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      // color: color,

      gradient: LinearGradient(
        colors: [
          color,
          color.withOpacity(0.4),
        ],
      ),
      // boxShadow: [
      //   BoxShadow(
      //     color: color.withOpacity(0.5),
      //     offset: const Offset(1, 2),
      //     blurRadius: 2,
      //   ),
      // ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(50),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 210),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(Icons.done,
              color: useWhiteForeground(color) ? Colors.white : Colors.black),
        ),
      ),
    ),
  );
}

Color rgbColor(String data) {
  try {
    final x = data.replaceAll('rgb(', '').replaceAll(')', '');
    final y = x.split(',').map((e) => double.parse(e).toInt()).toList();

    Color color = Color.fromRGBO(y[0], y[1], y[2], 1);
    return color;
  } catch (e) {
    return Colors.white;
  }
}

// The blocky color picker you can alter the layout and shape.
class BlockPicker extends StatefulWidget {
  const BlockPicker({
    Key? key,
    this.pickerColor,
    this.onColorChanged,
    required this.availableColors,
    this.layoutBuilder = _defaultLayoutBuilder,
    this.itemBuilder = _defaultItemBuilder,
  }) : super(key: key);

  final ColorsModel? pickerColor;
  final ValueChanged<ColorsModel>? onColorChanged;
  final List<ColorsModel> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  @override
  State<StatefulWidget> createState() => _BlockPickerState();
}

class _BlockPickerState extends State<BlockPicker> {
  ColorsModel? _currentColor;

  @override
  void initState() {
    _currentColor = widget.pickerColor;
    super.initState();
  }

  void changeColor(ColorsModel color) {
    setState(() => _currentColor = color);
    widget.onColorChanged!(color);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
      (ColorsModel color, [bool? _, Function? __]) => widget.itemBuilder(
        color,
        (_currentColor == color) && (widget.pickerColor == color),
        () => changeColor(color),
      ),
    );
  }
}

// The blocky color picker you can alter the layout and shape with multiple choice.
class MultipleChoiceBlockPicker extends StatefulWidget {
  const MultipleChoiceBlockPicker({
    Key? key,
    this.pickerColors,
    this.onColorsChanged,
    required this.availableColors,
    this.layoutBuilder = _defaultLayoutBuilder,
    this.itemBuilder = _defaultItemBuilder,
  }) : super(key: key);

  final List<ColorsModel>? pickerColors;
  final ValueChanged<List<ColorsModel>?>? onColorsChanged;
  final List<ColorsModel> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  @override
  State<StatefulWidget> createState() => _MultipleChoiceBlockPickerState();
}

class _MultipleChoiceBlockPickerState extends State<MultipleChoiceBlockPicker> {
  List<ColorsModel>? _currentColors;

  @override
  void initState() {
    _currentColors = widget.pickerColors;
    super.initState();
  }

  void toggleColor(ColorsModel color) {
    setState(() => _currentColors!.contains(color)
        ? _currentColors!.remove(color)
        : _currentColors!.add(color));
    widget.onColorsChanged!(_currentColors);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
      (ColorsModel color, [bool? _, Function? __]) => widget.itemBuilder(
        color,
        _currentColors!.contains(color) && widget.pickerColors!.contains(color),
        () => toggleColor(color),
      ),
    );
  }
}
