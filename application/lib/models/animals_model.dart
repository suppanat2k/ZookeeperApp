// To parse this JSON data, do
//
//     final animals = animalsFromJson(jsonString);

import 'dart:convert';

List<Animals> animalsFromJson(String str) => List<Animals>.from(json.decode(str).map((x) => Animals.fromJson(x)));

String animalsToJson(List<Animals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Animals {
    int? animalId;
    String? animalName;
    String? spicies;
    String? type;
    int? duration;
    int? roomId;
    String? roomName;
    int? seats;
    int? unitPrice;

    Animals({
        this.animalId,
        this.animalName,
        this.spicies,
        this.type,
        this.duration,
        this.roomId,
        this.roomName,
        this.seats,
        this.unitPrice,
    });

    factory Animals.fromJson(Map<String, dynamic> json) => Animals(
        animalId: json["animal_id"],
        animalName: json["animal_name"],
        spicies: json["spicies"],
        type: json["type"],
        duration: json["duration"],
        roomId: json["room_id"],
        roomName: json["room_name"],
        seats: json["seats"],
        unitPrice: json["unit_price"],
    );

    Map<String, dynamic> toJson() => {
        "animal_id": animalId,
        "animal_name": animalName,
        "spicies": spicies,
        "type": type,
        "duration": duration,
        "room_id": roomId,
        "room_name": roomName,
        "seats": seats,
        "unit_price": unitPrice,
    };
}
