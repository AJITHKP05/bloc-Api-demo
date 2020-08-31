part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoggingEvent extends AuthEvent {
  final String email;
  final String password;
  LoggingEvent(this.email, this.password);
}

class NotLoggedInEvent extends AuthEvent {}

class LoggedEvent extends AuthEvent {}

class LoggedFailedEvent extends AuthEvent {}

class NoInternetEvent extends AuthEvent {}
