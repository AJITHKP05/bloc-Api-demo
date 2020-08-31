part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class NoDataState extends DataState {}

class DataShowState extends DataState {}
