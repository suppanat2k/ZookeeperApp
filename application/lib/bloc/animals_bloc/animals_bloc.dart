// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zookeeper_app/repositiories/zoo_repositories.dart';

import '../../models/animals_model.dart';

part 'animals_event.dart';
part 'animals_state.dart';

class AnimalsBloc extends Bloc<AnimalsEvent, AnimalsState> {
  AnimalsBloc() : super(AnimalsInitial()) {
    final ZooRepositories zooRepositories = ZooRepositories();

    on<AnimalsGetList>((event, emit) async {
      emit(AnimalsLoading());
      try {
        final animalFetch = await zooRepositories.fetchAnimals();
        emit(AnimalsLoaded(animalFetch));
      } catch (e) {
        emit(AnimalsFailed(e.toString()));
      }
    });
  }
}
