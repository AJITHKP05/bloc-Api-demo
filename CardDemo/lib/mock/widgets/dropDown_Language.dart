import 'package:flutter/material.dart';

class DropDownLanguage extends StatefulWidget {
  @override
  _DropDownLanguageState createState() => _DropDownLanguageState();
}

class _DropDownLanguageState extends State<DropDownLanguage> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton<String>(
        focusColor: Colors.white,
        value: dropdownValue,

        hint: Text('Select Language'),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 40,
        // iconEnabledColor: Colors.amberAccent,
        // elevation: 16,
        style: TextStyle(color: Colors.blue),
        underline: Container(
          height: 1,
          color: Colors.blue,
        ),
        items: <String>['English', 'Malayalam ', 'Hindi']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
      ),
    );
  }
}
