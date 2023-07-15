part of 'admin_page_bloc.dart';

abstract class AdminPageEvent extends Equatable {
  const AdminPageEvent();

  @override
  List<Object> get props => [];
}

class ChangeAdminPage extends AdminPageEvent {
  final int pageIndex;
  const ChangeAdminPage(this.pageIndex);
}

class AnimalEditPage extends AdminPageEvent {
  final Animalmanagemodel animalDataModel;
  const AnimalEditPage(this.animalDataModel);
}

class StageEditPage extends AdminPageEvent {
  final Stagemanagemodel stageDataModel;
  const StageEditPage(this.stageDataModel);
}

class RoundEditPage extends AdminPageEvent {
  final Stagemanagemodel stageDataModel;
  const RoundEditPage(this.stageDataModel);
}

class AnimalEditValidate extends AdminPageEvent {
  final int animalId;
  final String spicies;
  final String type;
  final int duration;
  const AnimalEditValidate(
      this.animalId, this.spicies, this.type, this.duration);
}

class StageEditValidate extends AdminPageEvent {
  final int roomId;
  final int seats;
  final int unitPrice;
  const StageEditValidate(this.roomId, this.seats, this.unitPrice);
}

class RoundEditValidate extends AdminPageEvent {
  final int roomId;
  final String timeShow1;
  final String timeShow2;
  final String timeShow3;
  final int roundSeq1;
  final int roundSeq2;
  final int roundSeq3;
  const RoundEditValidate(this.roomId, this.timeShow1,this.timeShow2,this.timeShow3, this.roundSeq1, this.roundSeq2, this.roundSeq3);
}
