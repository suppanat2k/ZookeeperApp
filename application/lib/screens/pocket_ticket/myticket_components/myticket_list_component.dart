import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zookeeper_app/Routes/app_route.dart';
import 'package:zookeeper_app/bloc/ticket_bloc/ticket_bloc.dart';

import '../../../models/ticket_model.dart';

class MyTicketListComponent {
  //format time
  String formatTime(String? timeString) {
    final parsedTime = DateTime.parse('1970-01-01 $timeString');
    final formattedTime = DateFormat('h:mm a').format(parsedTime);
    return formattedTime;
  }

  

  Widget ticketItemList(BuildContext context, List<Ticketmodel> getTicketList) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: getTicketList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () {
              context
                  .read<TicketBloc>()
                  .add(TicketGetPopModel(getTicketList[index].tkCode));
              Navigator.pushNamed(context, AppRoute.myticketPop);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              clipBehavior: Clip.hardEdge,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(2, 2),
                        blurRadius: 4)
                  ]),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset("assets/images/icons/mytickets.png"),
                      )),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("${getTicketList[index].roundName}",
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Text("Stage: ${getTicketList[index].roomName}",
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Text("Animal: ${getTicketList[index].animalName}",
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Text(
                                "Show time: ${formatTime(getTicketList[index].timeShow)}",
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
