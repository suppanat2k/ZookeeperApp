// To parse this JSON data, do
//
//     final animalmanagemodel = animalmanagemodelFromJson(jsonString);

import 'dart:convert';

List<Animalmanagemodel> animalmanagemodelFromJson(String str) => List<Animalmanagemodel>.from(json.decode(str).map((x) => Animalmanagemodel.fromJson(x)));

String animalmanagemodelToJson(List<Animalmanagemodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Animalmanagemodel {
    int animalId;
    String? animalName;
    String? spicies;
    String? type;
    int? duration;

    Animalmanagemodel({
        required this.animalId,
        this.animalName,
        this.spicies,
        this.type,
        this.duration,
    });

    factory Animalmanagemodel.fromJson(Map<String, dynamic> json) => Animalmanagemodel(
        animalId: json["animal_id"],
        animalName: json["animal_name"],
        spicies: json["spicies"],
        type: json["type"],
        duration: json["duration"],
    );

    Map<String, dynamic> toJson() => {
        "animal_id": animalId,
        "animal_name": animalName,
        "spicies": spicies,
        "type": type,
        "duration": duration,
    };
}
