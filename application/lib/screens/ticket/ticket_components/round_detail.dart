import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/round_model.dart';

class RoundDetail {
  //format time
  String formatTime(String? timeString) {
    final parsedTime = DateTime.parse('1970-01-01 $timeString');
    final formattedTime = DateFormat('h:mm a').format(parsedTime);
    return formattedTime;
  }

  Widget roundDetail(Roundshow getRoundPopComp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${getRoundPopComp.roundName}",
          style: const TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Animal: ${getRoundPopComp.animalName}",
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Stage: ${getRoundPopComp.roomName}",
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Show time: ${formatTime(getRoundPopComp.timeShow)}",
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          getRoundPopComp.tkseats! >= getRoundPopComp.seats! 
              ? "SEAT OUT OF ROUND"
              : "Seats of round: ${getRoundPopComp.tkseats}/${getRoundPopComp.seats}",
          style: TextStyle(
            color: getRoundPopComp.tkseats! >= getRoundPopComp.seats!
                ? Colors.red
                : Colors.black87,
            fontSize: 14,
          ),
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
