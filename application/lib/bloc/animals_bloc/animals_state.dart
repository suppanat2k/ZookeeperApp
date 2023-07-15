part of 'animals_bloc.dart';

abstract class AnimalsState extends Equatable {
  const AnimalsState();

  @override
  List<Object> get props => [];
}

class AnimalsInitial extends AnimalsState {}

class AnimalsLoading extends AnimalsState {}

class AnimalsLoaded extends AnimalsState {
  final List<Animals> animalsList;
  const AnimalsLoaded(this.animalsList);
}

class AnimalsFailed extends AnimalsState {
  final String? message;
  const AnimalsFailed(this.message);
}
