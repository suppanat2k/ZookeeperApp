import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zookeeper_app/repositiories/zoo_repositories.dart';

import '../../models/ticket_model.dart';

part 'qrscan_event.dart';
part 'qrscan_state.dart';

class QrscanBloc extends Bloc<QrscanEvent, QrscanState> {
  QrscanBloc() : super(QrscanInitial()) {
    on<QrscanFoundCode>((event, emit) async {
      emit(QrscanLoding());
      try {
        var result =
            await ZooRepositories().getTicketScanner(tkCode: event.tkCode);
        emit(QrscanLoaded(result[0]));
      } catch (e) {
        emit(QrscanFailed());
      }
    });

    on<QrscanFoundCodeAccept>((event, emit) async {
      emit(QrscanLoding());
      try {
        await ZooRepositories().getTicketScannerAccept(tkCode: event.tkCode);
        emit(QrscanSuccess());
      } catch (e) {
        print(e.toString());
        emit(QrscanFailed());
      }
    });
  }
}
