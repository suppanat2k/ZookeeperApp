// ignore_for_file: must_be_immutable

part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class ResetCount extends CheckoutEvent {
  int roundSeq;
  ResetCount(this.roundSeq);
}

class IncrementCount extends CheckoutEvent {
  int roundSeq;
  IncrementCount(this.roundSeq);
}

class DecrementCount extends CheckoutEvent {
  int roundSeq;
  DecrementCount(this.roundSeq);
}

class CheckoutCreatTicket extends CheckoutEvent {
  int roundSeq;
  CheckoutCreatTicket(this.roundSeq);
}
