import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/login_bloc/login_bloc.dart';
import 'package:zookeeper_app/repositiories/auth_repositories.dart';
import 'package:zookeeper_app/screens/home/home_screen.dart';

import '../../bloc/authenticate_bloc/authenticate_bloc.dart';

class LoginScreen extends StatefulWidget {
  final UserRepositories userRepositories;
  const LoginScreen({super.key, required this.userRepositories});

  @override
  State<LoginScreen> createState() => _LoginScreenState(userRepositories);
}

class _LoginScreenState extends State<LoginScreen> {
  final UserRepositories userRepositories;
  _LoginScreenState(this.userRepositories);
  final usernameEdit = TextEditingController();
  final passwordEdit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login Failed"),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: usernameEdit,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.person), hintText: "Username"),
                        ),
                        TextFormField(
                          controller: passwordEdit,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.shield), hintText: "Password"),
                        ),
                        Container(
                          child: state is LoginLoading
                              ? ElevatedButton(
                                  onPressed: () {},
                                  child: const CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<LoginBloc>(context).add(
                                        LoginSubmited(
                                            username: usernameEdit.text,
                                            password: passwordEdit.text));
                                  },
                                  child: const Text("Login")),
                        )
                      ],
                    ))),
          );
        },
      ),
    );
  }
}
