part of 'authenticate_bloc.dart';

abstract class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticateEvent {}

class LoggedIn extends AuthenticateEvent {
  final String token;
  final String username;
  final String password;
  final int userId;
  final String role;

  const LoggedIn( 
      {required this.token, required this.username, required this.password,required this.role,required this.userId});

  @override
  List<Object> get props => [token, username, password];
}

class LoggedOut extends AuthenticateEvent {}
