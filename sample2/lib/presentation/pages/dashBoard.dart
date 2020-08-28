import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/block/data/data_bloc.dart';
import 'package:sample/mock/models/bookingModel.dart';
import 'package:sample/mock/widgets/bookingCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardPage extends StatelessWidget {
  final String name;
  DashBoardPage(this.name);

  @override
  Widget build(BuildContext context) {
    // getName();
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello $name"),
        ),
        body: Container(
            child: ListView(
          children: [
            BookingCard(),
          ],
        )));
  }
}
