part of 'animals_bloc.dart';

abstract class AnimalsEvent extends Equatable {
  const AnimalsEvent();

  @override
  List<Object> get props => [];
}

class AnimalsGetList extends AnimalsEvent {
  const AnimalsGetList();
}
