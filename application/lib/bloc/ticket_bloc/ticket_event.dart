part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class TicketGetList extends TicketEvent {}

class TicketGetPopModel extends TicketEvent {
  final String? tkCode;
  const TicketGetPopModel(this.tkCode);
}