import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/admin_page_bloc/admin_page_bloc.dart';
import 'package:zookeeper_app/screens/admin/admin_component/admin_tab.dart';
import 'package:zookeeper_app/screens/admin/manage_page/round_page.dart';
import 'package:zookeeper_app/screens/admin/manage_page/stage_page.dart';
import 'package:zookeeper_app/screens/other/loading_widget.dart';

import 'manage_page/animal_manage.dart';

class AdminManagement extends StatefulWidget {
  const AdminManagement({super.key});

  @override
  State<AdminManagement> createState() => _AdminManagementState();
}

class _AdminManagementState extends State<AdminManagement> {
  @override
  Widget build(BuildContext context) {
    // context.read<AdminPageBloc>().add(const ChangeAdminPage(0));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text("Management"),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.08),
              child: BlocBuilder<AdminPageBloc, AdminPageState>(
                builder: (context, state) {
                  if (state is AdminPageAnimals) {
                    return AdminComponent().tabManage(context, 0);
                  }
                  if (state is AdminPageStage) {
                    return AdminComponent().tabManage(context, 1);
                  }
                  if (state is AdminPageRound) {
                    return AdminComponent().tabManage(context, 2);
                  }
                  return AdminComponent().tabManage(context, -1);
                },
              )),
        ),
        body: BlocBuilder<AdminPageBloc, AdminPageState>(
          builder: (context, state) {
            if (state is AdminPageLoading) {
              return LoadingWidget().loadingList(context);
            }
            if (state is AdminPageAnimals) {
              return AnimalPage()
                  .animalMangement(context, state.animalManageData);
            }
            if (state is AdminPageStage) {
              return StagePage().stageMangement(context, state.stageManageData);
            }
            if (state is AdminPageRound) {
              return RoundOnStagePage()
                  .roundOnStageMangement(context, state.stageManageData,state.roundManageData);
            }
            return LoadingWidget().loadingList(context);
          },
        ),
      ),
    );
  }
}
