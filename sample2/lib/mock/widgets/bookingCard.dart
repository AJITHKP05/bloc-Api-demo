import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample/presentation/pages/last_page.dart';

class BookingCard extends StatefulWidget {
  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  // DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String dateOnly = DateTimeFormat.format(date, format: 'j');
    String dateTime = DateTimeFormat.format(date, format: 'j l Y, H:i A');
    String month = DateTimeFormat.format(date, format: 'F');

    print(date);
    var screenSize = MediaQuery.of(context).size;
    String title1 = "Cake - A - Tempt";
    String title2 = "waiting for allocation";
    // String title3 = "Cake - A - Tempt";
    return Container(
        width: screenSize.width,
        height: 135,
        // color: Colors.red,
        child: Container(
            padding: EdgeInsets.all(4),
            child: Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LastPage();
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.red,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Bookings",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "More options",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              height: 70,
                              width: screenSize.width * .16,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new Text(
                                    "$dateOnly ",
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    "$month",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$title1 \n",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                    Text(
                                      "$title2 \n",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                    Text(
                                      "$dateTime ",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                  ],
                                )),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\n",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                    Text(
                                      " \n",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                    Text(
                                      "Processing ",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
