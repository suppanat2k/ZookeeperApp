// To parse this JSON data, do
//
//     final roundmanagemodel = roundmanagemodelFromJson(jsonString);

import 'dart:convert';

List<Roundmanagemodel> roundmanagemodelFromJson(String str) => List<Roundmanagemodel>.from(json.decode(str).map((x) => Roundmanagemodel.fromJson(x)));

String roundmanagemodelToJson(List<Roundmanagemodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Roundmanagemodel {
    int roundSeq;
    String roundName;
    int animalId;
    String timeShow;
    int roomId;

    Roundmanagemodel({
        required this.roundSeq,
        required this.roundName,
        required this.animalId,
        required this.timeShow,
        required this.roomId,
    });

    factory Roundmanagemodel.fromJson(Map<String, dynamic> json) => Roundmanagemodel(
        roundSeq: json["round_seq"],
        roundName: json["round_name"],
        animalId: json["animal_id"],
        timeShow: json["time_show"],
        roomId: json["room_id"],
    );

    Map<String, dynamic> toJson() => {
        "round_seq": roundSeq,
        "round_name": roundName,
        "animal_id": animalId,
        "time_show": timeShow,
        "room_id": roomId,
    };
}
