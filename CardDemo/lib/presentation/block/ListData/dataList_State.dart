part of 'dataList_bloc.dart';

@immutable
abstract class DataListState {}

class InitialDataState extends DataListState {
  final List<CardModel> cards;
  InitialDataState(this.cards);
}

class NoDataState extends DataListState {}

class AddDataState extends DataListState {
  final List<CardModel> cards;
  AddDataState(this.cards);
}

class DeleteDataState extends DataListState {}
