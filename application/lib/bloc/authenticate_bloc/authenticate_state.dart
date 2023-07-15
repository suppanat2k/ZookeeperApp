part of 'authenticate_bloc.dart';

abstract class AuthenticateState extends Equatable {
  final String username;
  final String password;
  final String role;
  final int userId;
  const AuthenticateState({required this.username, required this.password,required this.role,required this.userId});

  @override
  List<Object> get props => [username, password,role,userId];
}

class AuthenticateInitial extends AuthenticateState {
  const AuthenticateInitial({required super.username, required super.password, required super.role, required super.userId});
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
  final int userId;

  @override
  // ignore: overridden_fields
  final String role;
  const Authenticated( 
      {required this.username, required this.password, required this.role,required this.userId})
      : super(username: username, password: password,role: role,userId: userId);

  @override
  List<Object> get props => [username, password, role,userId];
}

class UnAuthenticated extends AuthenticateState {
  const UnAuthenticated({required super.username, required super.password, required super.role, required super.userId});
}

class AuthenticateLoading extends AuthenticateState {
  const AuthenticateLoading({required super.username, required super.password, required super.role, required super.userId});
}
