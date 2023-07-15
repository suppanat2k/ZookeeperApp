import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:zookeeper_app/models/manage_model/animal_manage_model.dart';

import '../models/animals_model.dart';
import 'package:http/http.dart' as http;

import '../models/manage_model/round_manage_model.dart';
import '../models/manage_model/stage_manage.dart';
import '../models/round_model.dart';
import '../models/ticket_model.dart';

class ZooService {
  static String get hostUrl => dotenv.get("API_HOST", fallback: "");
  static String urlanimal = "$hostUrl/animals";
  static String urlround = "$hostUrl/round";
  static String urlcreatticket = "$hostUrl/ticket/create";
  static String urlticket = "$hostUrl/ticket";
  static String urlanimalmanage = "$hostUrl/animals/management";
  static String urlanimalupdate = "$hostUrl/animals/management/update";
  static String urlstagemanage = "$hostUrl/stage/management";
  static String urlstageupdate = "$hostUrl/stage/management/update";
  static String urlroundmanage = "$hostUrl/round/management";
  static String urlroundupdate = "$hostUrl/round/management/update";
  static String urlTicketScan = "$hostUrl/ticket/scan";
  static String urlTicketScanAccept = "$hostUrl/ticket/scan/accept";

  Future<List<Animals>> getAnimalList() async {
    try {
      Response response = await http.get(Uri.parse(urlanimal));
      return animalsFromJson(response.body).toList();
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return animalsFromJson(e.toString());
    }
  }

  Future<List<Roundshow>> getRoundList() async {
    try {
      Response response = await http.get(Uri.parse(urlround));
      return roundshowFromJson(response.body).toList();
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return roundshowFromJson(e.toString());
    }
  }

  Future<List<Ticketmodel>> getTicketList({required int userId}) async {
    try {
      Response response = await http.post(Uri.parse(urlticket),
          body: json.encode({"user_id": userId}),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          });
      return ticketmodelFromJson(response.body).toList();
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return ticketmodelFromJson(e.toString());
    }
  }

  Future postDataTicket(
      {required int userId,
      required int roundSeq,
      required int tkSeat,
      required int tkPrice}) async {
    try {
      Response response = await http.post(
        Uri.parse(urlcreatticket),
        body: json.encode({
          "user_id": userId,
          "round_seq": roundSeq,
          "tk_seats": tkSeat,
          "tk_price": tkPrice
        }),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
      );
      return response.body;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return roundshowFromJson(e.toString());
    }
  }

  //////////////////ADMIN////////////////////
  //Animals
  Future<List<Animalmanagemodel>> getAnimalManage() async {
    try {
      Response response = await http.get(Uri.parse(urlanimalmanage));
      return animalmanagemodelFromJson(response.body).toList();
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return animalmanagemodelFromJson(e.toString());
    }
  }

  Future postAnimalData(
      {required int animalid,
      required String spicies,
      required String type,
      required int duration}) async {
    try {
      Response response = await http.post(
        Uri.parse(urlanimalupdate),
        body: json.encode({
          "animal_id": animalid,
          "spicies": spicies,
          "type": type,
          "duration": duration
        }),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
      );
      return response.body;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return e.toString();
    }
  }

  //Stage
  Future<List<Stagemanagemodel>> getStageManage() async {
    try {
      Response response = await http.get(Uri.parse(urlstagemanage));
      return stagemanagemodelFromJson(response.body).toList();
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return stagemanagemodelFromJson(e.toString());
    }
  }

  Future postStageData(
      {required int roomId, required int seats, required int unitPrice}) async {
    try {
      Response response = await http.post(
        Uri.parse(urlstageupdate),
        body: json.encode(
            {"room_id": roomId, "seats": seats, "unit_price": unitPrice}),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
      );
      return response.body;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return e.toString();
    }
  }

  //Round
  Future<List<Roundmanagemodel>> getRoundData() async {
    try {
      Response response = await http.get(Uri.parse(urlroundmanage));
      return roundmanagemodelFromJson(response.body).toList();
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return roundmanagemodelFromJson(e.toString());
    }
  }

  Future postRoundData(
      {required int roundSeq,
      required String timeShow,
      required int roomId}) async {
    try {
      Response response = await http.post(
        Uri.parse(urlroundupdate),
        body: json.encode(
            {"round_seq": roundSeq, "time_show": timeShow, "room_id": roomId}),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
      );
      return response.body;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return e.toString();
    }
  }

  //ticket scan
  Future<List<Ticketmodel>> postTicketScan({required String tkCode}) async {
    try {
      Response response = await http.post(
        Uri.parse(urlTicketScan),
        body: json.encode({"tk_code": tkCode}),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
      );
      return ticketmodelFromJson(response.body).toList();
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return ticketmodelFromJson(e.toString());
    }
  }

  Future postTicketScanAccept({required String tkCode}) async {
    try {
      Response response = await http.post(
        Uri.parse(urlTicketScanAccept),
        body: json.encode({"tk_code": tkCode}),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
      );
      return response.body;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return ticketmodelFromJson(e.toString());
    }
  }
}
