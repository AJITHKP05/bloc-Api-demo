import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
part 'data_state.dart';
part 'data_event.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(NoDataState());
  final url =
      "http://165.22.208.43/api/method/login?usr=ebin_es@yahoo.com&pwd= 76676744@aA";
  final dataUrl =
      "http://165.22.208.43/api/method/orders.api.list_customer_active_orders";
  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is NoDataEvent) yield NoDataState();
    if (event is DataShowEvent) {
      // await login();
      await setData();
      yield DataShowState();
    }
  }

  Future setData() async {
    print("before data api");
    Response res = await post(dataUrl, headers: {
      'Accept': 'application/json',
    }, body: {}).then((response) {
      print(response.statusCode);
      print(response.body);
    });

    // List<dynamic> body = jsonDecode(res.body);

    // print(res.body);
    print("inside data bloc");
  }
}
