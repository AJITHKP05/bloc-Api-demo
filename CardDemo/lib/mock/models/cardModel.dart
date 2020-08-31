import 'package:flutter/material.dart';

class CardModel extends StatelessWidget {
  final String name;
  final String card;
  final String number;
  final String expiry;

  CardModel(this.name, this.card, this.number, this.expiry);
  @override
  Widget build(BuildContext context) {
    String lastNumber = number.substring(number.length - 5);
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(20),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "$card *****$lastNumber",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                  Image.asset(
                    "assets/card.png",
                    height: 30,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
              // Align(
              //     alignment: Alignment.topLeft,
              //     child: IconButton(icon: Icon(Icons.clear), onPressed: () {})),
            ],
          ),
          Text(
            " $name",
            style: TextStyle(fontSize: 14, color: Colors.blue),
          ),
          Text(
            " expires $expiry",
            style: TextStyle(fontSize: 14, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
