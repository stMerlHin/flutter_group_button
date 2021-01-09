import 'package:flutter/material.dart';
import 'package:flutter_group_button/src/group_items_alignment.dart';

/// By st merlHin from DexCorp
class CheckboxGroup extends StatefulWidget {


  const CheckboxGroup({
    Key key,
    @required this.child,
    @required this.onNewChecked,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.checkColor,
    this.priority = CheckboxPriority.textBeforeCheckbox,
    this.groupItemsAlignment,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.textBeforeCheckbox = true,
    this.textBelowCheckBox = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.internMainAxisAlignment = MainAxisAlignment.start,

  }): assert(child != null, "The child must not be null"),
        super(key: key);

  /// The color for the checkbox's [Material] when it has the input focus.
  final Color focusColor;

  /// The color for the checkbox's [Material] when a pointer is hovering over it.
  final Color hoverColor;

  /// The color to use when this checkbox button is checked.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  final Color activeColor;

  /// The color to use for the check icon when this checkbox is checked.
  ///
  /// Defaults to Color(0xFFFFFFFF)
  final Color checkColor;

  /// The list of the items of the CheckboxGroup
  final Map<Text, bool> child;

  /// Empty space to surround the [child].
  final EdgeInsetsGeometry margin;

  /// The alignment of the CheckboxGroup Items. It can be [GroupItemsAlignment.row] or
  /// [GroupItemsAlignment.column]
  final GroupItemsAlignment groupItemsAlignment;

  /// The main axis alignment of the CheckboxGroup
  final MainAxisAlignment mainAxisAlignment;

  /// The internal main axis alignment of the CheckboxGroup
  final MainAxisAlignment internMainAxisAlignment;

  /// Tells if the text must be below the checkbox
  final bool textBelowCheckBox;

  /// Tells if the text must come before or after the checkbox
  final bool textBeforeCheckbox;

  /// Tells if the [CheckboxPriority.textBeforeCheckbox] is important than
  /// [CheckboxPriority.textBelowCheckbox] or not
  final CheckboxPriority priority;

  /// Empty space to inscribe inside the RadioGroup.
  final EdgeInsetsGeometry padding;

  /// A callback to notify that a new check box is checked
  /// Return a list of checked items note That only the item Name is returned
  /// (A String)
  final ValueChanged<List<String>> onNewChecked;

  @override
  State createState() {
    return _CheckboxGroupState();
  }

}

class _CheckboxGroupState extends State<CheckboxGroup> {

  
  void updateSelected(Text key, bool value, List<String> checked) {
    setState(() {
      widget.child[key] = !widget.child[key];
      widget.child.forEach((key, value) {
        if (value) {
          checked.add(key.data);
        }
      });
      widget.onNewChecked(checked);
    });
  }
  
  Checkbox createNewCheckBox(Text key, bool value, ThemeData themeData, List<String> checked) {
    return new Checkbox(
        value: value,
        checkColor: widget.checkColor ?? const Color(0xFFFFFFFF),
        activeColor: widget.activeColor ??
            themeData.toggleableActiveColor,
        focusColor: widget.focusColor ?? themeData.focusColor,
        hoverColor: widget.hoverColor ?? themeData.hoverColor,
        onChanged: (bool b) {
          setState(() {
            widget.child[key] = b;
            widget.child.forEach((key, value) {
              if (value) {
                checked.add(key.data);
              }
            });
            widget.onNewChecked(checked);
          });
        });
  }
  
  GestureDetector createNewGesture(Text key, bool value, ThemeData themeData, List<String> checked) {
    return new GestureDetector(
      child: key,
      onTap: () {
        updateSelected(key, value, checked);
      },
    );
  }

  List<Widget> checkboxes(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    List<Widget> l = [];
    List<String> checked = [];
    if(widget.child.length > 0) {
      /// Checking the priority of the alignment
      if(widget.priority == CheckboxPriority.textBelowCheckbox) {
        if (widget.textBelowCheckBox) {
          widget.child.forEach((key, value) {
            Column column = new Column(
              mainAxisAlignment: widget.internMainAxisAlignment,
              children: [
                createNewGesture(key, value, themeData, checked),
                createNewCheckBox(key, value, themeData, checked)
              ],
            );
            l.add(column);
          });
        } else {
          widget.child.forEach((key, value)  {
            Column column = new Column(
              mainAxisAlignment: widget.internMainAxisAlignment,
              children: [
                createNewCheckBox(key, value, themeData, checked),
                createNewGesture(key, value, themeData, checked)
              ],
            );
            l.add(column);
          });
        }
      } else {
        if (widget.textBeforeCheckbox) {
          widget.child.forEach((key, value) {
            Row row = new Row(
              mainAxisAlignment: widget.internMainAxisAlignment,
              children: [
                createNewGesture(key, value, themeData, checked),
                createNewCheckBox(key, value, themeData, checked)
              ],
            );
            l.add(row);
          });
        } else {
          widget.child.forEach((key, value) {
            Row row = new Row(
              mainAxisAlignment: widget.internMainAxisAlignment,
              children: [
                createNewCheckBox(key, value, themeData, checked),
                createNewGesture(key, value, themeData, checked)
              ],
            );
            l.add(row);
          });
        }
      }
    }
    return l;
  }


  @override
  Widget build(BuildContext context) {
    if(widget.groupItemsAlignment == GroupItemsAlignment.row) {
      return new Container(
          margin: widget.margin,
          padding: widget.padding,
          child: new Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: checkboxes(context),
          )
      ) ;
    } else {

      return new Container(
          margin: widget.margin,
          padding: widget.padding,
          child: new Column(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: checkboxes(context),
          )
      );
    }
  }
}

enum CheckboxPriority {

  /// Tells if the text must come before the checkbox
  textBeforeCheckbox,

  /// Tells if the text must come after checkbox
  textBelowCheckbox
}
