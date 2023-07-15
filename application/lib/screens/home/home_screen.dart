import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/authenticate_bloc/authenticate_bloc.dart';
import 'package:zookeeper_app/screens/home/home_components/animals_list.dart';
import 'package:zookeeper_app/screens/home/home_components/options_button.dart';
import 'package:zookeeper_app/screens/home/home_components/ticket_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Colors.black,
        title: Image.asset("assets/images/logo/Logo.png",width: 100,),
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.person))
          IconButton(
              onPressed: () {
                context.read<AuthenticateBloc>().add(LoggedOut());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.06),
            child: Container()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: BlocBuilder<AuthenticateBloc, AuthenticateState>(
        builder: (context, state) {
          if (state.role == "user") {
            return TicketButton(context: context).userTicketBtn();
          } else if (state.role == "advance") {
            return TicketButton(context: context).adminTicketBtn();
          } else {
            return TicketButton(context: context).userTicketBtn();
          }
        },
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
        child: Column(
          children: [
            const Expanded(flex: 8, child: AnimalShowList()),
            Expanded(
                flex: 2, child: BlocBuilder<AuthenticateBloc, AuthenticateState>(
        builder: (context, state) {
          if (state.role == "user") {
            return OptionButton(context: context).userOptionBtn();
          } else if (state.role == "advance") {
            return OptionButton(context: context).adminOptionBtn();
          } else {
            return OptionButton(context: context).userOptionBtn();
          }
        },
                ))
          ],
        ),
      ),
    );
  }
}


