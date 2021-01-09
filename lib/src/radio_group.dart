import 'package:flutter/material.dart';
import 'package:flutter_group_button/src/group_items_alignment.dart';

/// By st merlHin from DexCorp
/// A class to ease the creation of [Radio] button with [Text]
class RadioGroup extends StatefulWidget {

  const RadioGroup({
    Key key,
    @required this.groupItemsAlignment,
    @required this.onSelectionChanged,
    this.defaultSelectedItem = 0,
    this.children = const <Widget>[],
    this.textBeforeRadio = true,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.textBelowRadio = true,
    this.priority = RadioPriority.textBeforeRadio,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.internMainAxisAlignment = MainAxisAlignment.start,
  }) : assert(children != null, "Children must not be empty"),
        super(key: key);

  /// The default item to select for the RadioGroup
  final int defaultSelectedItem;

  /// The list of the items of the RadioGroup. It's good to pass
  /// a list of [Text]
  final List<Widget> children;

  /// Empty space to inscribe inside the RadioGroup. The [children], if any, is
  /// placed inside this padding.
  final EdgeInsetsGeometry padding;

  /// Tells if the Text must come before or after the radio button
  final bool textBeforeRadio;

  /// Tells if the Text must be below or above the Radio
  final bool textBelowRadio;

  /// Tells if the [textBelowRadio] is important or not than [textBeforeRadio]
  final RadioPriority priority;

  /// Empty space to surround the [children].
  final EdgeInsetsGeometry margin;

  /// The alignment of the Radio Items. It can be [GroupItemsAlignment.row] or
  /// [GroupItemsAlignment.column]
  final GroupItemsAlignment groupItemsAlignment;

  /// The main axis alignment of the RadioGroup
  final MainAxisAlignment mainAxisAlignment;

  /// the internal axis alignment of the RadioGroup
  final MainAxisAlignment internMainAxisAlignment;

  /// Callback called when the selected item changed
  /// it returns the index of the selected radio. note
  /// that the index start at 0.
  final ValueChanged<int> onSelectionChanged;

  /// The color for the radio's [Material] when it has the input focus.
  final Color focusColor;

  /// The color for the radio's [Material] when a pointer is hovering over it.
  final Color hoverColor;

  /// The color to use when this radio button is selected.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  final Color activeColor;

  @override
  State createState() {
    return new _RadioGroupState();
  }

}

class _RadioGroupState extends State<RadioGroup> {
  int selected = -1;
  int defaultChanged = 0;
  bool selectedConfigured = false;

  /// For hot reload
  void initSelected() {
    if(defaultChanged != widget.defaultSelectedItem) {
      selected = widget.defaultSelectedItem;
      defaultChanged = selected;

    }

  }

  /// Update the selected item when a change happens
  void updateSelectedItem(int  x) {
    if (x != selected) {
      selected = x;
      if(widget.onSelectionChanged != null) {
        widget.onSelectionChanged(x);
      }
    }
  }

  /// Create a new Radio
  Radio createNewRadio(int value, int selected, ThemeData themeData) {
    return Radio(
        value: value,
        groupValue: selected,
        activeColor: widget.activeColor ?? themeData.toggleableActiveColor,
        focusColor: widget.focusColor ?? themeData.focusColor,
        hoverColor: widget.hoverColor ?? themeData.hoverColor,
        onChanged: (i) {
          setState(() {
            updateSelectedItem(i);
          });
        });
  }

  /// Create a new Widget with gestureDetector
  GestureDetector createNewGesture(int value) {
    return GestureDetector(
        onTap: () {
          setState(() {
            updateSelectedItem(value);
          });
        },
        child: widget.children.elementAt(value)

    );
  }

  /// Create the RadioGroup
  List<Widget> radios(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    initSelected();
    List<Widget> l = [];
    if(widget.children.length > 0) {
      /// Checking the priority of the alignment
      if(widget.priority == RadioPriority.textBelowRadio) {
        if (widget.textBelowRadio) {
          for (int value = 0; value < widget.children.length; ++value) {
            Column column = new Column(
              mainAxisAlignment: widget.internMainAxisAlignment,
              children: [
                createNewGesture(value),
                createNewRadio(value, selected, themeData)
              ],
            );
            l.add(column);
          }
        } else {
          for (int value = 0; value < widget.children.length; ++value) {
            Column column = new Column(
              mainAxisAlignment: widget.internMainAxisAlignment,
              children: [
                createNewRadio(value, selected, themeData),
                createNewGesture(value)
              ],
            );
            l.add(column);
          }
        }
      } else {
        if (widget.textBeforeRadio) {
          for (int value = 0; value < widget.children.length; ++value) {
            Row row = new Row(
              mainAxisAlignment: widget.internMainAxisAlignment,
              children: [
                createNewGesture(value),
                createNewRadio(value, selected, themeData)
              ],
            );
            l.add(row);
          }
        } else {
          for (int value = 0; value < widget.children.length; ++value) {
            Row row = new Row(
              mainAxisAlignment: widget.internMainAxisAlignment,
              children: [
                createNewRadio(value, selected, themeData),
                createNewGesture(value)
              ],
            );
            l.add(row);
          }
        }
      }
    }
    return l;
  }

  @override
  void initState() {
    super.initState();
    selected = widget.defaultSelectedItem;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.groupItemsAlignment == GroupItemsAlignment.row) {
      return new Container(
        margin: widget.margin,
        padding: widget.padding,
        child: new Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          children: radios(context),
        )
      ) ;
    } else {
      return new Container(
        margin: widget.margin,
        padding: widget.padding,
        child: new Column(
          mainAxisAlignment: widget.mainAxisAlignment,
          children: radios(context),
        )
      );
    }
  }

}

enum RadioPriority {
  /// Tells if the textBeforeRadio
  textBeforeRadio,

  /// Tells if the textBelowRadio is more important than textBeforeRadio
  textBelowRadio,
}
