// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositiories/auth_repositories.dart';
import '../../repositiories/zoo_repositories.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutCountSeat(1, 0)) {
    final UserRepositories userRepositories = UserRepositories();

    on<IncrementCount>((event, emit) async {
      if (state.countSeat < 100) {
        var result = await ZooRepositories().fetchRound();
        var getRoundModel =
            result.where((e) => e.roundSeq == event.roundSeq).toList();

        emit(CheckoutCountSeat(state.countSeat + 1,
            getRoundModel[0].unitPrice! * (state.countSeat + 1)));
      }
    });

    on<ResetCount>((event, emit) async {
      var result = await ZooRepositories().fetchRound();
      var getRoundModel =
          result.where((e) => e.roundSeq == event.roundSeq).toList();
      emit(CheckoutCountSeat(state.countSeat = 1, getRoundModel[0].unitPrice!));
    });

    on<DecrementCount>((event, emit) async {
      if (state.countSeat > 1) {
        var result = await ZooRepositories().fetchRound();
        var getRoundModel =
            result.where((e) => e.roundSeq == event.roundSeq).toList();
        emit(CheckoutCountSeat(state.countSeat - 1,
            getRoundModel[0].unitPrice! * (state.countSeat - 1)));
      }
    });

    on<CheckoutCreatTicket>((event, emit) async {
      emit(CheckoutLoading(state.countSeat, state.countPrice));
      var result = await ZooRepositories().fetchRound();
      var getRoundModel =
          result.where((e) => e.roundSeq == event.roundSeq).toList();
      if (state.countSeat > getRoundModel[0].seats! ||
          state.countSeat >
              (getRoundModel[0].seats! - getRoundModel[0].tkseats!)) {
        emit(CheckoutFailed(state.countSeat, state.countPrice));
      } else {
        try {
          var idToken = await userRepositories.idRead();
          await ZooRepositories().sendTicketData(
              userId: int.parse(idToken),
              roundSeq: getRoundModel[0].roundSeq,
              tkSeat: state.countSeat,
              tkPrice: state.countPrice);
          emit(CheckoutSuccess(state.countSeat, state.countPrice));
        } catch (e) {
          emit(CheckoutFailed(state.countSeat, state.countPrice));
        }
      }
    });
  }
}
