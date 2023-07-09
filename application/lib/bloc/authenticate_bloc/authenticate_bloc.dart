import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zookeeper_app/repositiories/auth_repositories.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  final UserRepositories userRepositories;

  AuthenticateBloc({required this.userRepositories})
      : super(const UnAuthenticated(password: '', username: '', role: '')) {
    on<AppStarted>((event, emit) async {
      bool hasToken = await userRepositories.hasToken();
      var usernameToken = await userRepositories.usernameRead();
      var passwordToken = await userRepositories.passwordRead();
      var roleToken = await userRepositories.roleRead();
      if (hasToken) {
        emit(Authenticated(username: usernameToken,password: passwordToken, role: roleToken));
      } else {
        emit(const UnAuthenticated(password: '', username: '', role: ''));
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(const AuthenticateLoading(password: '', username: '', role: ''));
      await userRepositories.preToken(
          event.token, event.username, event.password,event.role);
      emit(Authenticated(username: event.username,password: event.password, role: event.role));
    });

    on<LoggedOut>((event, emit) async {
      emit(const AuthenticateLoading(password: '', username: '', role: ''));
      await userRepositories.deleteToken();
      emit(const UnAuthenticated(password: '', username: '', role: ''));
    });
  }
}
