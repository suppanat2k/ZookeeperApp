import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/ticket_bloc/ticket_bloc.dart';
import 'package:zookeeper_app/screens/other/loading_widget.dart';

import 'myticket_components/myticket_list_component.dart';

class MyTicketList extends StatefulWidget {
  const MyTicketList({super.key});

  @override
  State<MyTicketList> createState() => _MyTicketListState();
}

class _MyTicketListState extends State<MyTicketList> {
  @override
  Widget build(BuildContext context) {
    context.read<TicketBloc>().add(TicketGetList());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          "MY TICKETS",
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
      ),
      body: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          if (state is TicketLoading) {
            return LoadingWidget().loadingList(context);
          }
          if (state is TicketLoaded) {
            if (state.ticketList.isEmpty) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/icons/mytickets.png",width: 20,),
                    const SizedBox(width: 10,),
                    const Text("You not have ticket.",style: TextStyle(color: Colors.black38,fontSize: 16),),
                  ],
                ),
              );
            }
            return MyTicketListComponent()
                .ticketItemList(context, state.ticketList);
          }
          return LoadingWidget().loadingList(context);
        },
      ),
    );
  }
}
