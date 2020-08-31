part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class NoDataEvent extends DataEvent {}

class DataShowEvent extends DataEvent {}
