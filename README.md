# flutter_group_button

A flutter package which contains basics grouped buttons like radio buttons and checkboxes

## VERSION
    [0.0.1]

## Table of content
   * [getting start](#getting-start)
   * [General info](#general-info)

## General info
   * [RadioGroup](#radiogroup)
   * [CheckboxGroup](#checkboxgroup)

## Getting start
To use this package, add `flutter_group_button^[version]` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/)

#### Illustration
```yaml
dependencies:
        flutter_group_button: ^0.0.1
```

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.


## RadioGroup
   The RadioGroup has many arguments for more flexibility which are optional. You can implements theme
   for your needs. Important to know that both the radio button and the radio's label are clickable

* [RadioGroup parameters list](#radiogroup-parameters-list)
* [RadioGroup parameters details](#radiogroup-parameters-details)
* [Short illustration of essentials](#short-illustration)

## RadioGroup parameters list
     groupItemsAlignment,
     onSelectionChanged,
     defaultSelectedItem = 0,
     children,
     textBeforeRadio = true,
     padding = const EdgeInsets.all(0),
     margin = const EdgeInsets.all(0),
     activeColor,
     focusColor,
     hoverColor,
     textBelowRadio = true,
     priority = RadioPriority.textBeforeRadio,
     mainAxisAlignment = MainAxisAlignment.start,
     internMainAxisAlignment = MainAxisAlignment.start,
     
## RadioGroup parameters details

#### (@Required) means that the argument is required by the Widget to work properly
    Important to know there is only 3 required parameters for RadioGroup to work
    they are:
        groupItemsAlignment,
        children,
        onSelectionChanged
#### (@Optional) means that the argument is not required by the RadioGroup to work

 (@Required)
  ### groupItemsAlignment
   The alignment of the RadioGroup Items. It can be GroupItemsAlignment.row for row alignment
    or GroupItemsAlignment.column for column alignment. Note that according to its value and 
    the parent of the RadioGroup, you will have to play with both 
   [mainAxisAlignment](#mainaxisalignment) and 
   [internalMainAxisAlignment](#internmainaxisalignment) to make the RadioGroup be at the right place
   
 (@Required)
  ### children
   The item or the list of the items label of the RadioGroup. You can pass any widget or list of widget 
    you want but It's good to pass a Text widget or a list of Text widget like shown   
  [here](#short-illustration).
    Note that you can add a Style to the Text or use any widget you want.
    
 (@Required)
  ### onSelectionChanged
   Callback called when the selected item changed
    it returns the index of the selected radio button. Note
    that the index start at 0.
    
 (@Optional)
  ### defaultSelectedItem
   (int): Is the default item to select for the RadioGroup. By default the first item is selected. 
    Note that the index begin at 0. If you don't want any item to be selected, just give a
    negative value to it.
  
  (@Optional)
  ### padding
   (EdgeInsetsGeometry): Empty space to inscribe inside the RadioGroup.

 (@Optional)
  ### textBeforeRadio
   (bool) which tells if the items label must come before or after the radio button.
    By default it's set to true. if you want the opposite, just set it to false

 (@Optional)
  ### textBelowRadio
   (bool): which tells if the item's label must be below or above the Radio. By default, 
    it's set to true. If you want the opposite, just set it to false. One thing to take in consideration,
    the item's label can not be before and below the radio at the same time. it can only be 
    (before of after the radio button depending on the textBeforeRadio's value) or 
    (below or above the radio button depending on the textBelowRadio's value), so there is a
   [priority](#priority) to respect.

 (@Optional)
  ### priority
   (RadioPriority) which tells if the [textBeforeRadio] is important or not than [textBelowRadio].
    it can take two values (RadioPriority.textBeforeRadio or RadioPriority.textBelowRadio).
    By default, textBeforeRadio is important than textBelowRadio

 (@Optional)
  ### margin
   (EdgeInsetsGeometry) Empty space to surround the the RadioGroup items.


 (@Optional)
  ### mainAxisAlignment)
   (MainAxisAlignment) The main axis alignment of the RadioGroup.
    Depending on the container of the RadioGroup parent, you could need it or not.

 (@Optional)
  ### internMainAxisAlignment
   (MainAxisAlignment): the internal axis alignment of the RadioGroup.
    You can control the main axis alignment of the radio button and its label.
    Depending on the RadioGroup parent, you can have to play with both mainAxisAlignment 
    and this internalRadioAxisAlignment 

 (@Optional)
  ### focusColor
   (Color): The color for the radio's [Material] when it has the input focus.
    
 (@Optional)
  ### hoverColor;
   (Color): The color for the radio's [Material] when a pointer is hovering over it.

(@Optional)
  ### activeColor
   (Color): The color to use when this radio button is selected.
    Defaults to [ThemeData.toggleableActiveColor].


## Short illustration   
  ```dart
  import 'package:flutter/material.dart';  
  import 'package:flutter_group_button/flutter_group_button';  
   
  void main() {
    runApp(MyApp());
  }
  
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter group button demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'RadioGroup demo'),
      );
    }
  }
  
  class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);
    final String title;
  
    @override
    _MyHomePageState createState() => _MyHomePageState();
  }
  
  class _MyHomePageState extends State<MyHomePage> {
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: RadioGroup(
              children: [
                Text("Choice 1"),
                Text("Choice 2"),
                /// fell free to add a textStyle or change the Text to Cupertino
                /// Text widget
                Text("Choice 3")
              ],
              groupItemsAlignment: GroupItemsAlignment.column,
              mainAxisAlignment: MainAxisAlignment.center,
              internMainAxisAlignment: MainAxisAlignment.center,
              /// In reality this is not needed
              priority: RadioPriority.textBeforeRadio,
              defaultSelectedItem: -1,
              onSelectionChanged: (selection) {
                print(selection);
              })
        ),
      );
    }
  }
  ```
This is the result of the code above 
[<img src="https://github.com/stMerlHin/repo_im/blob/main/radio_demo.png?raw=true" width="250"/>](https://github.com/stMerlHin/repo_im/blob/main/radio_demo.png?raw=true)
    
## CheckboxGroup
   The CheckboxGroup has many arguments for more flexibility which are optional. You can implements theme
   for your needs. Important to know that both the checkbox button and the checkbox's label are clickable

* [List of parameters](#checkboxgroup-parameters-list)
* [CheckboxGroup parameters details](#checkbox-parameters-details)
* [Short illustration of essentials](#checkbox-short-illustration)

## CheckBoxGroup parameters list
    child,
    onNewChecked,
    activeColor,
    focusColor,
    hoverColor,
    checkColor,
    priority = CheckboxPriority.textBeforeCheckbox,
    groupItemsAlignment,
    padding = const EdgeInsets.all(0),
    margin = const EdgeInsets.all(0),
    textBeforeCheckbox = true,
    textBelowCheckBox = true,
    mainAxisAlignment = MainAxisAlignment.start,
    internMainAxisAlignment = MainAxisAlignment.start,



## Checkbox parameters details
#### (@Required) means that the argument is required by the Widget to work properly
    Important to know, there is only 3 required parameters for CheckboxGroup to work.
    They are : 
        groupItemsAlignment,
        child,
        onNewChecked,
#### (@Optional) means that the argument is not required by the Widget to work
 
   ### groupItemsAlignment (@Required);
   (GroupItemsAlignment): The alignment of the CheckboxGroup Items. It can be GroupItemsAlignment.row for row alignment
     or GroupItemsAlignment.column for column alignment. Note that according to its value and 
     the parent of the RadioGroup, you will have to play with both
   [mainAxisAlignment](#mainaxisalignment-optional) and [internalRadioAxisAlignment](#internmainaxisalignment-optional)
     to make the RadioGroup be right place
    
 
   ### child (@Required)
   (Map<Text, bool)): The items of the CheckboxGroup.    
   [here](#short-illustration) is short illustration. Note that you can add a Style to the Text.
     
     
   ### onNewChecked (@Required)
   A callback to notify that a new check box is checked
     Return a list of checked items. Note That only the item's label (String) is returned
   
   ### padding (@Optional);
   (EdgeInsetsGeometry): Empty space to inscribe inside the CheckboxGroup.
 
   ### textBeforeCheckbox (@Optional)
   (bool): tells if the items label must come before or after the checkbox.
     By default it's set to true. if you want the opposite, just set it to false
 
   ### textBelowCheckbox (@Optional);
   (bool): tells if the item's label must be below or above the checkbox. By default, 
     it's set to true. If you want the opposite, just set it to false. One thing to take in consideration,
     the item's label can not be before and below the checkbox at the same time. it can only be 
     (before of after the checkbox depending on the textBeforeCheckbox's value) or 
     (below or above the checkbox depending on the textBelowCheckbox's value), so there is a
   [priority](#priority-optional) to respect.
 
   ### priority (@Optional)
   (CheckboxPriority): tells if the [textBeforeCheckbox] is important or not than [textBelowCheckbox].
     it can take two values (CheckboxPriority.textBeforeCheckbox or CheckboxPriority.textBelowCkeckbox).
     By default, textBeforeCheckbox is important than textBelowCheckbox
 
   ### margin (@Optional)
   (EdgeInsetsGeometry): Empty space to surround the the RadioGroup items.
 
 
   ### mainAxisAlignment (@Optional)
   (MainAxisAlignment): The main axis alignment of the CheckboxGroup.
     Depending on the container of the CheckboxGroup parent, you could need it or not.
 
   ### internMainAxisAlignment (@Optional)
   (MainAxisAlignment): the internal axis alignment of the CheckboxGroup.
     You can control the main axis alignment of the checkbox and its label.
     Depending on the CheckboxGroup parent, you can have to play with both 
   [mainAxisAlignment](#mainaxisalignment-optional) and this internalRadioAxisAlignment 
 
   ### focusColor (@Optional)
   (Color): The color for the checkbox's [Material] when it has the input focus.
     
   ### hoverColor (@Optional)
   (Color): The color for the checkbox's [Material] when a pointer is hovering over it.
 
   ### activeColor (@Optional)
   (Color): The color to use when the checkbox is checked.
     Defaults to [ThemeData.toggleableActiveColor].
     
  
  ###  checkColor (@Optional)
   Color) The color to use for the check icon when this checkbox is checked.
    Defaults to Color(0xFFFFFFFF)


## Checkbox short illustration 

```dart
import 'package:flutter/material.dart';  
import 'package:flutter_group_button/flutter_group_button';  
 
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter group button demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'CheckboxGroup demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: CheckboxGroup(
              child: {
                Text("Choice 1"): false,
                Text("Choice 2"): true,
                Text("Choice 3"): false
              },
              groupItemsAlignment: GroupItemsAlignment.column,
              mainAxisAlignment: MainAxisAlignment.center,
              internMainAxisAlignment: MainAxisAlignment.center,
              priority: CheckboxPriority.textBeforeCheckbox,
              onNewChecked: (l) {
                print(l);
              })
      ),
    );
  }
}
```
This is the result of the code above
[<img src="https://github.com/stMerlHin/repo_im/blob/main/checkbox_demo.png?raw=true" width="250"/>](https://github.com/stMerlHin/repo_im/blob/main/checkbox_demo.png?raw=true)
