part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  final String username;
  final String password;

  const LoginState({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LoginInitial extends LoginState {
  const LoginInitial({required super.username, required super.password});
}

class LoginLoading extends LoginState {
  const LoginLoading({required super.username, required super.password});
}

class LoginSuccess extends LoginState {
  @override
  // ignore: overridden_fields
  final String username;
  @override
  // ignore: overridden_fields
  final String password;
  const LoginSuccess({required this.username, required this.password})
      : super(username: username, password: password);

  @override
  List<Object> get props => [username, password];
}

class LoginFailed extends LoginState {
  final String message;
  const LoginFailed(this.message,{required super.username, required super.password});
}
