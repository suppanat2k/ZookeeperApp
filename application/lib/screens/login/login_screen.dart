import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/login_bloc/login_bloc.dart';
import 'package:zookeeper_app/repositiories/auth_repositories.dart';

class LoginScreen extends StatefulWidget {
  final UserRepositories userRepositories;
  const LoginScreen({super.key, required this.userRepositories});

  @override
  // ignore: no_logic_in_create_state
  State<LoginScreen> createState() => _LoginScreenState(userRepositories);
}

class _LoginScreenState extends State<LoginScreen> {
  final UserRepositories userRepositories;
  _LoginScreenState(this.userRepositories);
  final usernameEdit = TextEditingController();
  final passwordEdit = TextEditingController();
  bool isShowPassword = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 1),
            content: Text("Username or Password wrong! Please try again.."),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Image.asset("assets/images/logo/Logo.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              onTapOutside: (event) => FocusScope.of(context)
                                  .requestFocus(FocusNode()),
                              style: const TextStyle(color: Colors.white),
                              controller: usernameEdit,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  prefixIconColor: Colors.white,
                                  fillColor: Colors.black,
                                  filled: true,
                                  hintMaxLines: 1,
                                  hintText: "Username",
                                  hintStyle: const TextStyle(
                                      color: Colors.white54, fontSize: 14),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              obscureText: isShowPassword ? false : true,
                              onTapOutside: (event) => FocusScope.of(context)
                                  .requestFocus(FocusNode()),
                              style: const TextStyle(color: Colors.white),
                              controller: passwordEdit,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (!isShowPassword) {
                                            isShowPassword = true;
                                          } else {
                                            isShowPassword = false;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        isShowPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white30,
                                      )),
                                  prefixIcon: const Icon(Icons.shield),
                                  prefixIconColor: Colors.white,
                                  fillColor: Colors.black,
                                  filled: true,
                                  hintMaxLines: 1,
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                      color: Colors.white54, fontSize: 14),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () {},
                              child: const Text("forgot your password?",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                                child: state is LoginLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(LoginSubmited(
                                                  username: usernameEdit.text,
                                                  password: passwordEdit.text));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          decoration: BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: const Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text("Or",
                                style: TextStyle(color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.06,
                                      decoration: BoxDecoration(
                                          color: Colors.white30,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/icons/google.png",
                                            width: 30,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            "Google",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.06,
                                      decoration: BoxDecoration(
                                          color: Colors.white30,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/icons/line.png",
                                            width: 30,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            "Line",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )),
                          ),
                        ],
                      ))),
            ),
          );
        },
      ),
    );
  }
}
