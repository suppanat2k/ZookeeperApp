import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zookeeper_app/bloc/authenticate_bloc/authenticate_bloc.dart';
import 'package:zookeeper_app/models/users_model.dart';
import 'package:zookeeper_app/repositiories/auth_repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepositories userRepositories;
  final AuthenticateBloc authenticateBloc;
  LoginBloc({required this.userRepositories, required this.authenticateBloc})
      : super(const LoginInitial(password: '', username: '')) {
    on<LoginSubmited>((event, emit) async {
      emit(LoginLoading(username: event.username, password: event.password));
      try {
        final users = await userRepositories.login(
            username: event.username, password: event.password);
        final token = usersFromJson(users).token;
        final username = usersFromJson(users).username;
        final password = usersFromJson(users).password;
        final role = usersFromJson(users).role;
        authenticateBloc.add(
            LoggedIn(token: token, username: username, password: password,role: role));
        emit(LoginSuccess(username: event.username, password: event.password));
      } catch (e) {
        emit(const LoginFailed(password: '', username: ''));
      }
    });
  }
}
