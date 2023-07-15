import 'package:zookeeper_app/models/animals_model.dart';
import 'package:zookeeper_app/models/manage_model/animal_manage_model.dart';
import 'package:zookeeper_app/models/ticket_model.dart';
import 'package:zookeeper_app/services/zoo_services.dart';

import '../models/manage_model/stage_manage.dart';
import '../models/round_model.dart';

class ZooRepositories {
  final service = ZooService();

  Future<List<Animals>> fetchAnimals() async {
    return service.getAnimalList();
  }

  Future<List<Roundshow>> fetchRound() async {
    return service.getRoundList();
  }

  Future<List<Ticketmodel>> fetchTicket({required int userId}) async {
    return service.getTicketList(userId: userId);
  }

  Future sendTicketData(
      {required int userId,
      required int roundSeq,
      required int tkSeat,
      required int tkPrice}) async {
    return service.postDataTicket(
        userId: userId, roundSeq: roundSeq, tkSeat: tkSeat, tkPrice: tkPrice);
  }

  //animal repo manage
  Future<List<Animalmanagemodel>> fetchAnimalManage() async {
    return service.getAnimalManage();
  }

  Future sendAnimalUpdate(
      {required int animalId,
      required String spicies,
      required String type,
      required int duration}) async {
    return service.postAnimalData(
        animalid: animalId, spicies: spicies, type: type, duration: duration);
  }

  //stage repo manage
  Future<List<Stagemanagemodel>> fetchStageManage() async {
    return service.getStageManage();
  }

  Future sendStageUpdate(
      {required int roomId, required int seats, required int unitPrice}) async {
    return service.postStageData(
        roomId: roomId, seats: seats, unitPrice: unitPrice);
  }

  //Round repo manage
  Future getRoundData() async {
    return service.getRoundData();
  }

  Future sendRoundUpdate(
      {required int roomId,
      required String timeShow,
      required int roundSeq}) async {
    return service.postRoundData(
        roomId: roomId, timeShow: timeShow, roundSeq: roundSeq);
  }

  //ticket Scanner
  Future<List<Ticketmodel>> getTicketScanner({required String tkCode}) async {
    return service.postTicketScan(tkCode: tkCode);
  }

  Future getTicketScannerAccept({required String tkCode}) async {
    return service.postTicketScanAccept(tkCode: tkCode);
  }
}

class NetworkError extends Error {}
