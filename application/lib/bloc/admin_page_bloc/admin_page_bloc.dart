// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/manage_model/animal_manage_model.dart';
import '../../models/manage_model/round_manage_model.dart';
import '../../models/manage_model/stage_manage.dart';
import '../../models/round_model.dart';
import '../../repositiories/zoo_repositories.dart';

part 'admin_page_event.dart';
part 'admin_page_state.dart';

class AdminPageBloc extends Bloc<AdminPageEvent, AdminPageState> {
  AdminPageBloc() : super(AdminPageInitial()) {
    on<ChangeAdminPage>((event, emit) async {
      emit(AdminPageLoading());
      try {
        if (event.pageIndex == 0) {
          final result = await ZooRepositories().fetchAnimalManage();
          return emit(AdminPageAnimals(result));
        }
        if (event.pageIndex == 1) {
          final result = await ZooRepositories().fetchStageManage();
          return emit(AdminPageStage(result));
        }
        if (event.pageIndex == 2) {
          final result = await ZooRepositories().fetchStageManage();
          final roundResult = await ZooRepositories().getRoundData();
          return emit(AdminPageRound(result, roundResult));
        }
      } catch (e) {
        emit(AdminPageFailed());
      }
    });

    //animal
    on<AnimalEditPage>((event, emit) async {
      emit(AdminPageLoading());
      try {
        emit(AnimalEditPageState(event.animalDataModel));
      } catch (e) {
        emit(AdminPageFailed());
      }
    });

    on<AnimalEditValidate>((event, emit) async {
      emit(AdminPageLoading());
      try {
        await ZooRepositories().sendAnimalUpdate(
            animalId: event.animalId,
            spicies: event.spicies,
            type: event.type,
            duration: event.duration);
        emit(AnimalEditPageStateSuccess());
      } catch (e) {
        emit(AdminPageFailed());
      }
    });

    //stage
    on<StageEditPage>((event, emit) async {
      emit(AdminPageLoading());
      try {
        emit(StageEditPageState(event.stageDataModel));
      } catch (e) {
        emit(AdminPageFailed());
      }
    });

    on<StageEditValidate>((event, emit) async {
      emit(AdminPageLoading());
      try {
        await ZooRepositories().sendStageUpdate(
            roomId: event.roomId,
            seats: event.seats,
            unitPrice: event.unitPrice);
        emit(StageEditPageStateSuccess());
      } catch (e) {
        emit(AdminPageFailed());
      }
    });

    //Round
    on<RoundEditPage>((event, emit) async {
      emit(AdminPageLoading());
      try {
        var result = await ZooRepositories().fetchRound();
        var getListRound = result
            .where((e) => e.roomId == event.stageDataModel.roomId)
            .toList();
        emit(RoundEditPageState(getListRound));
      } catch (e) {
        emit(AdminPageFailed());
      }
    });

    on<RoundEditValidate>((event, emit) async {
      emit(AdminPageLoading());
      try {
        await ZooRepositories().sendRoundUpdate(roomId: event.roomId,timeShow: event.timeShow1,roundSeq: event.roundSeq1);
        await ZooRepositories().sendRoundUpdate(roomId: event.roomId,timeShow: event.timeShow2,roundSeq: event.roundSeq2);
        await ZooRepositories().sendRoundUpdate(roomId: event.roomId,timeShow: event.timeShow3,roundSeq: event.roundSeq3);
        emit(RoundEditPageStateSuccess());
      } catch (e) {
        emit(AdminPageFailed());
      }
    });
  }
}
