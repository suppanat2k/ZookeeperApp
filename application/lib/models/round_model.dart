// To parse this JSON data, do
//
//     final roundshow = roundshowFromJson(jsonString);

import 'dart:convert';

List<Roundshow> roundshowFromJson(String str) => List<Roundshow>.from(json.decode(str).map((x) => Roundshow.fromJson(x)));

String roundshowToJson(List<Roundshow> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Roundshow {
    int roundSeq;
    String? roundName;
    int? animalId;
    String timeShow;
    int roomId;
    String? roomName;
    int? seats;
    int? unitPrice;
    String? animalName;
    String? type;
    int? tkseats;

    Roundshow({
        required this.roundSeq,
        this.roundName,
        this.animalId,
        required this.timeShow,
        required this.roomId,
        this.roomName,
        this.seats,
        this.unitPrice,
        this.animalName,
        this.type,
        this.tkseats,
    });

    factory Roundshow.fromJson(Map<String, dynamic> json) => Roundshow(
        roundSeq: json["round_seq"],
        roundName: json["round_name"],
        animalId: json["animal_id"],
        timeShow: json["time_show"],
        roomId: json["room_id"],
        roomName: json["room_name"],
        seats: json["seats"],
        unitPrice: json["unit_price"],
        animalName: json["animal_name"],
        type: json["type"],
        tkseats: json["tkseats"],
    );

    Map<String, dynamic> toJson() => {
        "round_seq": roundSeq,
        "round_name": roundName,
        "animal_id": animalId,
        "time_show": timeShow,
        "room_id": roomId,
        "room_name": roomName,
        "seats": seats,
        "unit_price": unitPrice,
        "animal_name": animalName,
        "type": type,
        "tkseats": tkseats,
    };
}
