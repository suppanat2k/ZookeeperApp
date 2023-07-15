// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zookeeper_app/repositiories/auth_repositories.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  final UserRepositories userRepositories;

  AuthenticateBloc({required this.userRepositories})
      : super(const UnAuthenticated(password: '', username: '', role: '', userId: 0)) {
    on<AppStarted>((event, emit) async {
      bool hasToken = await userRepositories.hasToken();
      var usernameToken = await userRepositories.usernameRead();
      var passwordToken = await userRepositories.passwordRead();
      var roleToken = await userRepositories.roleRead();
      var idToken = await userRepositories.idRead();
      if (hasToken) {
        emit(Authenticated(username: usernameToken,password: passwordToken, role: roleToken, userId: int.parse(idToken)));
      } else {
        emit(const UnAuthenticated(password: '', username: '', role: '', userId: 0));
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(const AuthenticateLoading(password: '', username: '', role: '', userId: 0));
      await userRepositories.preToken(
          event.token, event.username, event.password,event.role,event.userId);
      emit(Authenticated(username: event.username,password: event.password, role: event.role, userId: 0));
    });

    on<LoggedOut>((event, emit) async {
      emit(const AuthenticateLoading(password: '', username: '', role: '', userId: 0));
      await userRepositories.deleteToken();
      emit(const UnAuthenticated(password: '', username: '', role: '', userId: 0));
    });
  }
}
