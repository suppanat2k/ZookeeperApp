import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zookeeper_app/bloc/authenticate_bloc/authenticate_bloc.dart';
import 'package:zookeeper_app/repositiories/auth_repositories.dart';
import 'package:zookeeper_app/screens/home/home_screen.dart';
import 'package:zookeeper_app/screens/login/login_screen.dart';

import 'bloc/login_bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepositories userRepositories = UserRepositories();
  await dotenv.load(fileName: ".env");
  runApp(BlocProvider<AuthenticateBloc>(
    create: (context) =>
        AuthenticateBloc(userRepositories: userRepositories)..add(AppStarted()),
    child: MainApp(userRepositories: userRepositories),
  ));
}

class MainApp extends StatelessWidget {
  final UserRepositories userRepositories;
  const MainApp({super.key, required this.userRepositories});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
          authenticateBloc: BlocProvider.of<AuthenticateBloc>(context),
          userRepositories: userRepositories),
    );

    return MultiBlocProvider(
      providers: [loginBloc],
      child: MaterialApp(home: BlocBuilder<AuthenticateBloc, AuthenticateState>(
        builder: (context, state) {
          context.read<AuthenticateBloc>().add(AppStarted());
          if (state is Authenticated) {
            return const HomeScreen();
          }
          if (state is UnAuthenticated) {
            return LoginScreen(userRepositories: userRepositories);
          }
          if (state is AuthenticateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      )),
    );
  }
}
