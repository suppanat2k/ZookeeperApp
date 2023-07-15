part of 'qrscan_bloc.dart';

abstract class QrscanState extends Equatable {
  const QrscanState();
  
  @override
  List<Object> get props => [];
}

class QrscanInitial extends QrscanState {}

class QrscanLoding extends QrscanState {}

class QrscanLoaded extends QrscanState {
   final Ticketmodel getTicketScanModel;
  const QrscanLoaded(this.getTicketScanModel);
}

class QrscanSuccess extends QrscanState {}

class QrscanFailed extends QrscanState {}

