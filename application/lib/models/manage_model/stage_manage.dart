// To parse this JSON data, do
//
//     final stagemanagemodel = stagemanagemodelFromJson(jsonString);

import 'dart:convert';

List<Stagemanagemodel> stagemanagemodelFromJson(String str) => List<Stagemanagemodel>.from(json.decode(str).map((x) => Stagemanagemodel.fromJson(x)));

String stagemanagemodelToJson(List<Stagemanagemodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stagemanagemodel {
    int roomId;
    String? roomName;
    int seats;
    int unitPrice;
    int? animalId;

    Stagemanagemodel({
        required this.roomId,
        this.roomName,
        required this.seats,
        required this.unitPrice,
        this.animalId,
    });

    factory Stagemanagemodel.fromJson(Map<String, dynamic> json) => Stagemanagemodel(
        roomId: json["room_id"],
        roomName: json["room_name"],
        seats: json["seats"],
        unitPrice: json["unit_price"],
        animalId: json["animal_id"],
    );

    Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "room_name": roomName,
        "seats": seats,
        "unit_price": unitPrice,
        "animal_id": animalId,
    };
}
