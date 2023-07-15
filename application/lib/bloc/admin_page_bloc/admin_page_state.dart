part of 'admin_page_bloc.dart';

abstract class AdminPageState extends Equatable {
  const AdminPageState();

  @override
  List<Object> get props => [];
}

class AdminPageInitial extends AdminPageState {}

class AdminPageLoading extends AdminPageState {}

class AdminPageAnimals extends AdminPageState {
  final List<Animalmanagemodel> animalManageData;
  const AdminPageAnimals(this.animalManageData);
}

class AnimalEditPageState extends AdminPageState {
  final Animalmanagemodel animalEditData;
  const AnimalEditPageState(this.animalEditData);
}

class AnimalEditPageStateSuccess extends AdminPageState {}

class AdminPageStage extends AdminPageState {
  final List<Stagemanagemodel> stageManageData;
  const AdminPageStage(this.stageManageData);
}

class StageEditPageState extends AdminPageState {
  final Stagemanagemodel stageEditData;
  const StageEditPageState(this.stageEditData);
}

class StageEditPageStateSuccess extends AdminPageState {}

class AdminPageRound extends AdminPageState {
  final List<Roundmanagemodel> roundManageData;
  final List<Stagemanagemodel> stageManageData;
  const AdminPageRound(this.stageManageData, this.roundManageData);
}

class RoundEditPageState extends AdminPageState {
  final List<Roundshow> roundEditData;
  const RoundEditPageState(this.roundEditData);
}

class RoundEditPageStateSuccess extends AdminPageState {}

class AdminPageFailed extends AdminPageState {}
