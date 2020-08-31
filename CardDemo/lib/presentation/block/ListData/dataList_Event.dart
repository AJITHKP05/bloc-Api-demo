part of 'dataList_bloc.dart';

@immutable
abstract class DataListEvent {}

class InitialDataEvent extends DataListEvent {}

class NoDataEvent extends DataListEvent {}

class AddDataEvent extends DataListEvent {
  final CardModel cardModel;
  AddDataEvent(this.cardModel);
}

class DeleteDataEvent extends DataListEvent {
  final CardModel cardModel;
  DeleteDataEvent(this.cardModel);
}
