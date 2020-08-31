import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/presentation/pages/dashBoard.dart';
import 'package:sample/presentation/pages/login_page.dart';

void main() => runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (context) => LoginPage(),
          // 'dashboard': (context) => DashBoardPage(),
          // 'createUser' : (context)=>CreateUser(),
        }));
