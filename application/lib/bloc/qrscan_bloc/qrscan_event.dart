part of 'qrscan_bloc.dart';

abstract class QrscanEvent extends Equatable {
  const QrscanEvent();

  @override
  List<Object> get props => [];
}

class QrscanFoundCode extends QrscanEvent {
  final String tkCode;
  const QrscanFoundCode(this.tkCode);
}

class QrscanFoundCodeAccept extends QrscanEvent {
  final String tkCode;
  const QrscanFoundCodeAccept(this.tkCode);
}
