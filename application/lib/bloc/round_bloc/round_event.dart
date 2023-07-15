part of 'round_bloc.dart';

abstract class RoundEvent extends Equatable {
  const RoundEvent();

  @override
  List<Object> get props => [];
}

class RoundGetList extends RoundEvent {
  const RoundGetList();
}

class SearchRoundEvent extends RoundEvent {
  final String? searchString;
  const SearchRoundEvent(this.searchString);
}

class RoundGetPopModel extends RoundEvent {
  final int? roundSeq;
  const RoundGetPopModel(this.roundSeq);
}
