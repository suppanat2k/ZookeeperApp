import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:zookeeper_app/Routes/app_route.dart';
import 'package:zookeeper_app/bloc/admin_page_bloc/admin_page_bloc.dart';
import 'package:zookeeper_app/bloc/animals_bloc/animals_bloc.dart';
import 'package:zookeeper_app/bloc/authenticate_bloc/authenticate_bloc.dart';
import 'package:zookeeper_app/bloc/checkout_bloc/checkout_bloc.dart';
import 'package:zookeeper_app/bloc/qrscan_bloc/qrscan_bloc.dart';
import 'package:zookeeper_app/bloc/round_bloc/round_bloc.dart';
import 'package:zookeeper_app/bloc/ticket_bloc/ticket_bloc.dart';
import 'package:zookeeper_app/repositiories/auth_repositories.dart';
import 'package:zookeeper_app/screens/home/home_screen.dart';
import 'package:zookeeper_app/screens/login/login_screen.dart';

import 'bloc/login_bloc/login_bloc.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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

    final animalsBloc = BlocProvider<AnimalsBloc>(
      create: (context) => AnimalsBloc()..add(const AnimalsGetList()),
    );

        final roundBloc = BlocProvider<RoundBloc>(
      create: (context) => RoundBloc()..add(const RoundGetList()),
    );

            final checkoutBloc = BlocProvider<CheckoutBloc>(
      create: (context) => CheckoutBloc(),
    );

    final ticketBloc = BlocProvider<TicketBloc>(
      create: (context) => TicketBloc());

       final adminPageBloc = BlocProvider<AdminPageBloc>(
      create: (context) => AdminPageBloc()..add(const ChangeAdminPage(0)));

      final qrScanBloc = BlocProvider<QrscanBloc>(
      create: (context) => QrscanBloc());

    return MultiBlocProvider(
      providers: [loginBloc,animalsBloc,roundBloc,checkoutBloc,ticketBloc,adminPageBloc,qrScanBloc],
      child: MaterialApp(
          theme: ThemeData(fontFamily: "OpenSans"),
          routes: AppRoute().getAll,
          home: BlocBuilder<AuthenticateBloc, AuthenticateState>(
            builder: (context, state) {
              FlutterNativeSplash.remove();
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
