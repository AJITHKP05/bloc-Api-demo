import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sample/mock/models/cardModel.dart';

part 'dataList_State.dart';
part 'dataList_Event.dart';

class DataListBloc extends Bloc<DataListEvent, DataListState> {
  DataListBloc() : super(NoDataState());

  List<CardModel> _cardList = [
    CardModel("Bob", " HDFC Bank Debt Card", "85238451845", "01 2025"),
    CardModel("Mannar", " ICICI Bank Debt Card", "852353565", "08 2023"),
    CardModel("Marley", " State Bank Debt Card", "852353565", "04 2023"),
  ];

  @override
  Stream<DataListState> mapEventToState(DataListEvent event) async* {
    if (event is NoDataEvent) yield NoDataState();
    if (event is InitialDataEvent) yield InitialDataState(_cardList);
    if (event is AddDataEvent) {
      if (event.cardModel != null) {
        _cardList.add(event.cardModel);
        // print("data Added+ ${_cardList.length}");
      }

      yield AddDataState(_cardList);
      yield InitialDataState(_cardList);
    }
    if (event is DeleteDataEvent) {
      print("${event.cardModel.name}+ dtcfgyfgh");
      _cardList.remove(event.cardModel);
      yield DeleteDataState();
      yield InitialDataState(_cardList);
    }
  }

  List<CardModel> getCardList() => _cardList;
}
