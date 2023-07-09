import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/authenticate_bloc/authenticate_bloc.dart';
import 'package:zookeeper_app/bloc/login_bloc/login_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) {
            return Text("Welcome ${state.role}");
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthenticateBloc>().add(LoggedOut());
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Text("Welcome"),
      ),
    );
  }
}
