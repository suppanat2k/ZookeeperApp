// To parse this JSON data, do
//
//     final ticketmodel = ticketmodelFromJson(jsonString);

import 'dart:convert';

List<Ticketmodel> ticketmodelFromJson(String str) => List<Ticketmodel>.from(json.decode(str).map((x) => Ticketmodel.fromJson(x)));

String ticketmodelToJson(List<Ticketmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ticketmodel {
    String? tkStatus;
    String tkCode;
    int tkSeats;
    int tkPrice;
    String roundName;
    String timeShow;
    String animalName;
    int duration;
    String roomName;

    Ticketmodel({
        this.tkStatus,
        required this.tkCode,
        required this.tkSeats,
        required this.tkPrice,
        required this.roundName,
        required this.timeShow,
        required this.animalName,
        required this.duration,
        required this.roomName,
    });

    factory Ticketmodel.fromJson(Map<String, dynamic> json) => Ticketmodel(
        tkStatus: json["tk_status"],
        tkCode: json["tk_code"],
        tkSeats: json["tk_seats"],
        tkPrice: json["tk_price"],
        roundName: json["round_name"],
        timeShow: json["time_show"],
        animalName: json["animal_name"],
        duration: json["duration"],
        roomName: json["room_name"],
    );

    Map<String, dynamic> toJson() => {
        "tk_status": tkStatus,
        "tk_code": tkCode,
        "tk_seats": tkSeats,
        "tk_price": tkPrice,
        "round_name": roundName,
        "time_show": timeShow,
        "animal_name": animalName,
        "duration": duration,
        "room_name": roomName,
    };
}
