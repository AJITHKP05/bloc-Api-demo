import 'package:flutter/material.dart';

class LastPage extends StatefulWidget {
  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LastPage"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            InkWell(
              child: RichText(
                text: TextSpan(
                  text: 'FLUTTER',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'flutter', style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        height: 200.0,
                        child: Container(
                            height: 200,
                            color: Colors.amber,
                            child: Center(child: Text(' Bottom Sheet'))));
                  },
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              child: RichText(
                text: TextSpan(
                  text: 'FLUTTER',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'flutter', style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: Colors.amber,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Modal BottomSheet'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ));
  }
}
