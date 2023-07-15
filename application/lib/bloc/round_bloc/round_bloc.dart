// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zookeeper_app/models/round_model.dart';
import 'package:zookeeper_app/repositiories/zoo_repositories.dart';

part 'round_event.dart';
part 'round_state.dart';

class RoundBloc extends Bloc<RoundEvent, RoundState> {
  RoundBloc() : super(RoundInitial()) {
    on<RoundGetList>((event, emit) async {
      emit(RoundLoading());
      try {
        var result = await ZooRepositories().fetchRound();
        emit(RoundLoaded(result));
      } catch (e) {
        emit(RoundFailed(e.toString()));
      }
    });

    on<SearchRoundEvent>((event, emit) async {
      emit(RoundLoading());
      try {
        var result = await ZooRepositories().fetchRound();
        var getSearch = result
            .where(
              (e) =>
                  e.type!
                      .toLowerCase()
                      .contains(event.searchString.toString().toLowerCase()) || e.animalName!
                      .toLowerCase()
                      .contains(event.searchString.toString().toLowerCase()) ||
                  e.roomName!
                      .toLowerCase()
                      .contains(event.searchString.toString().toLowerCase()),
            )
            .toList();
        emit(RoundLoaded(getSearch));
      } catch (e) {
        emit(RoundFailed(e.toString()));
      }
    });

    on<RoundGetPopModel>((event, emit) async {
      emit(RoundLoading());
      try {
        var result = await ZooRepositories().fetchRound();
        var getRoundModel =
            result.where((e) => e.roundSeq == event.roundSeq).toList();
        emit(RoundPopUp(getRoundModel[0]));
      } catch (e) {
        emit(RoundFailed(e.toString()));
      }
    });
  }
}
