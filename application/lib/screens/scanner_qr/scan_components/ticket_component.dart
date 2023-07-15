import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zookeeper_app/bloc/qrscan_bloc/qrscan_bloc.dart';
import 'package:zookeeper_app/models/ticket_model.dart';

class TicketScanComponent {
  //format time
  String formatTime(String? timeString) {
    if (timeString == null) {}
    final parsedTime = DateTime.parse('1970-01-01 $timeString');
    final formattedTime = DateFormat('hh:mm a').format(parsedTime);
    return formattedTime;
  }

  final currency = NumberFormat("#,##0.00", "en_US");

  Widget ticketScanComponent(
      BuildContext context, Ticketmodel getTicketScanData) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(3, 3),
                  blurRadius: 5,
                  spreadRadius: 1)
            ]),
        child: Wrap(alignment: WrapAlignment.center, children: [
          Column(
            children: [
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "assets/images/icons/mytickets.png",
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Code: ${getTicketScanData.tkCode}",
                      style: TextStyle(color: Colors.black38, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${getTicketScanData.roundName}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("Animal: ${getTicketScanData.animalName}",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text("Room: ${getTicketScanData.roomName}",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text("Show time: ${formatTime(getTicketScanData.timeShow)}",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text("Seat: ${getTicketScanData.tkSeats} Seat",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text(
                      "Price: ${currency.format(getTicketScanData.tkPrice)} THB",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              getTicketScanData.tkStatus == 'N'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500))),
                        TextButton(
                            onPressed: () {
                              context.read<QrscanBloc>().add(
                                  QrscanFoundCodeAccept(
                                      getTicketScanData.tkCode.toString()));
                              Navigator.pop(context);
                            },
                            child: Text("Accept",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)))
                      ],
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: Text(
                        "This ticket has already used",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
            ],
          ),
        ]),
      ),
    );
  }
}
