part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class LoggingState extends AuthState {
  // final String email;
  // final String password;
  // LoggingState(this.email, this.password);
}

class NotLoggedInState extends AuthState {}

class LoggedState extends AuthState {
  final String name;
  LoggedState(this.name);
}

class LoggedFailedState extends AuthState {}

class NoInternetState extends AuthState {}
