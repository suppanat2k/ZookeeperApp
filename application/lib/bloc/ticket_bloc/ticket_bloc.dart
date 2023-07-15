// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zookeeper_app/repositiories/auth_repositories.dart';

import '../../models/ticket_model.dart';
import '../../repositiories/zoo_repositories.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    final ZooRepositories zooRepositories = ZooRepositories();
    final UserRepositories userRepositories = UserRepositories();

    on<TicketGetList>((event, emit) async {
      emit(TicketLoading());
      try {
        var idToken = await userRepositories.idRead();
        final ticketFetch = await zooRepositories.fetchTicket(userId:int.parse(idToken));
        emit(TicketLoaded(ticketFetch));
      } catch (e) {
        emit(TicketFailed());
      }
    });

    on<TicketGetPopModel>((event, emit) async {
      emit(TicketLoading());
      try {
        var idToken = await userRepositories.idRead();
        final ticketFetch = await zooRepositories.fetchTicket(userId:int.parse(idToken));
           var getticketModel =
            ticketFetch.where((e) => e.tkCode == event.tkCode).toList();
        emit(TicketDetail(getticketModel[0]));
      } catch (e) {
        emit(TicketFailed());
      }
    });
  }
}
