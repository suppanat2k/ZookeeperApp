part of 'round_bloc.dart';

abstract class RoundState extends Equatable {
  const RoundState();
  
  @override
  List<Object> get props => [];
}

class RoundInitial extends RoundState {}

class RoundLoading extends RoundState {}

class RoundLoaded extends RoundState {
  final List<Roundshow> roundList;
  const RoundLoaded(this.roundList);
}

class RoundFailed extends RoundState {
  final String? message;
  const RoundFailed(this.message);
}

class RoundPopUp extends RoundState { 
  final Roundshow roundPopModel;
  const RoundPopUp(this.roundPopModel);
}

