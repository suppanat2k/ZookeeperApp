part of 'authenticate_bloc.dart';

abstract class AuthenticateState extends Equatable {
  final String username;
  final String password;
  final String role;
  const AuthenticateState({required this.username, required this.password,required this.role});

  @override
  List<Object> get props => [username, password,role];
}

class AuthenticateInitial extends AuthenticateState {
  const AuthenticateInitial({required super.username, required super.password, required super.role});
}

class Authenticated extends AuthenticateState {
  @override
  // ignore: overridden_fields
  final String username;
  @override
  // ignore: overridden_fields
  final String password;

  @override
  // ignore: overridden_fields
  final String role;
  const Authenticated(
      {required this.username, required this.password, required this.role})
      : super(username: username, password: password,role: role);

  @override
  List<Object> get props => [username, password, role];
}

class UnAuthenticated extends AuthenticateState {
  const UnAuthenticated({required super.username, required super.password, required super.role});
}

class AuthenticateLoading extends AuthenticateState {
  const AuthenticateLoading({required super.username, required super.password, required super.role});
}
