import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(NotLoggedInState());
  final url = "http://165.22.208.43/api/method/login";

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    var jsonData;
    SharedPreferences shared = await SharedPreferences.getInstance();
    if (event is LoggingEvent) {
      yield LoggingState();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        print("no internet");
        yield NoInternetState();
      } else {
        Response re = await login(event.email, event.password);
        jsonData = json.decode(re.body);
        shared.setString("name", jsonData['full_name']);
        print(shared.getString("name"));

        if (re.statusCode == 200) {
          print("${re.statusCode} codeee");
          yield LoggedState(shared.getString("name"));
        } else
          yield LoggedFailedState();
      }
      if (event is NotLoggedInEvent) yield NotLoggedInState();
      if (event is LoggedEvent) yield LoggedState(shared.getString("name"));
    }
  }

  Future login(email, password) async {
    print("$email  $password ");
    // print("before api");
    Response result;
    try {
      Response res = await post(url, headers: {
        'Accept': 'application/json',
      }, body: {
        "usr": "$email",
        "pwd": "$password"
        // ignore: missing_return
      }).then((response) {
        if (response.statusCode == 200) print(response.statusCode);
        print(response.body);
        print("before return");
        result = response;
        return response;
      });
    } catch (err) {}

    // List<dynamic> body = jsonDecode(res.body);

    // print(res.body);
    print("inside bloc");
    return result;
  }
}
