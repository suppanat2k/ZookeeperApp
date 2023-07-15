part of 'ticket_bloc.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  final List<Ticketmodel> ticketList;
  const TicketLoaded(this.ticketList);
}

class TicketFailed extends TicketState {}

class TicketDetail extends TicketState {
  final Ticketmodel ticketPopModel;
  const TicketDetail(this.ticketPopModel);
}
