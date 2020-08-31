import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DatePicker extends StatefulWidget {
  final DateCallback dateSelect;
  DatePicker(this.dateSelect);
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _dateTime;
  static DateTime now = DateTime.now();

  DateTime tomarrow = DateTime(now.year, now.month, now.day + 1);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            // Text("To",
            //     style: TextStyle(
            //       color: Colors.orange,
            //     )),
            ListTile(
                leading: Text(
                  "Expiry Date :",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                title: Text(
                  _dateTime == null
                      ? '$now.toLocal()'.split(
                            '-',
                          )[1] +
                          '  $now.toLocal()'.split(
                            '-',
                          )[0]
                      : "$_dateTime.toLocal()".split('-')[1] +
                          "  $_dateTime.toLocal()".split('-')[0],
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                trailing: Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                ),
                onTap: () {
                  showMonthPicker(
                          context: context,
                          initialDate: tomarrow,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2040))
                      .then((date) {
                    setState(() {
                      _dateTime = date;
                      widget.dateSelect(
                        "$_dateTime.toLocal()".split('-')[1] +
                            "  $_dateTime.toLocal()".split('-')[0],
                      );
                      print(date);
                    });
                  });
                })
          ],
        ));
  }
}

typedef DateCallback = void Function(String date);
