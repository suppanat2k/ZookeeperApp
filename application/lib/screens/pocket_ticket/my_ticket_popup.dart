import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:zookeeper_app/screens/other/loading_widget.dart';

import '../../bloc/ticket_bloc/ticket_bloc.dart';
import '../../models/ticket_model.dart';

class MyTicketPopUp extends StatefulWidget {
  const MyTicketPopUp({super.key});

  @override
  State<MyTicketPopUp> createState() => _MyTicketPopUpState();
}

class _MyTicketPopUpState extends State<MyTicketPopUp> {
  //format time
  String formatTime(String? timeString) {
    final parsedTime = DateTime.parse('1970-01-01 $timeString');
    final formattedTime = DateFormat('h:mm a').format(parsedTime);
    return formattedTime;
  }

  final currency = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<TicketBloc>().add(TicketGetList());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("TICKET DETAILS"),
            centerTitle: true,
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  context.read<TicketBloc>().add(TicketGetList());
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: BlocBuilder<TicketBloc, TicketState>(
            builder: (context, state) {
              if (state is TicketLoading) {
                return LoadingWidget().loadingList(context);
              }
              if (state is TicketDetail) {
                return ticketDetailsComponent(context, state.ticketPopModel);
              }
              return LoadingWidget().loadingList(context);
            },
          ),
          bottomNavigationBar: SizedBox(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height*0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.black,
                  child: Image.asset("assets/images/logo/Logo.png",width: 60,)),
              ],
            ),
          ),
          ),
    );
  }

  Widget ticketDetailsComponent(
      BuildContext context, Ticketmodel getTicketModel) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                QrImageView(
                  data: getTicketModel.tkCode,
                  version: QrVersions.auto,
                  size: MediaQuery.of(context).size.width * 0.6,
                ),
                Text(
                  getTicketModel.tkCode,
                  style: const TextStyle(
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 5)
                ]),
            child: const Text(
              "LIONGATE TICKET",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${getTicketModel.roundName}",
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Text("Animal: ${getTicketModel.animalName}",
              style: const TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(
            height: 5,
          ),
          Text("Stage: ${getTicketModel.roomName}",
              style: const TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(
            height: 5,
          ),
          Text("Show time: ${formatTime(getTicketModel.timeShow)}",
              style: const TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(
            height: 5,
          ),
          Text("My seat: ${getTicketModel.tkSeats} Seat",
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          const SizedBox(
            height: 5,
          ),
          Text("Price: ${currency.format(getTicketModel.tkPrice)} THB",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
