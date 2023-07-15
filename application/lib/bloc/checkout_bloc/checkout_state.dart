// ignore_for_file: must_be_immutable

part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  int countSeat;
  int countPrice;
  CheckoutState(this.countSeat, this.countPrice);

  @override
  List<Object> get props => [countSeat,countPrice];
}

class CheckoutInitial extends CheckoutState {
  CheckoutInitial(super.countSeat, super.countPrice);
}

class CheckoutLoading extends CheckoutState {
  CheckoutLoading(super.countSeat, super.countPrice);
}

class CheckoutSuccess extends CheckoutState {
  CheckoutSuccess(super.countSeat, super.countPrice);
}

class CheckoutCountSeat extends CheckoutState {
  @override
  // ignore: overridden_fields
  int countSeat;
  @override
  // ignore: overridden_fields
  int countPrice;
  CheckoutCountSeat(this.countSeat,this.countPrice) : super(countSeat, countPrice);

  @override
  List<Object> get props => [countSeat,countPrice];
}

class CheckoutFailed extends CheckoutState {
  CheckoutFailed(super.countSeat, super.countPrice);
}
