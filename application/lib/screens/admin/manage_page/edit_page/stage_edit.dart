import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/admin_page_bloc/admin_page_bloc.dart';
import 'package:zookeeper_app/bloc/animals_bloc/animals_bloc.dart';
import 'package:zookeeper_app/screens/other/loading_widget.dart';

class StageEditPageScreen extends StatefulWidget {
  const StageEditPageScreen({super.key});

  @override
  State<StageEditPageScreen> createState() => _StageEditPageScreenState();
}

class _StageEditPageScreenState extends State<StageEditPageScreen> {
  final TextEditingController seatController = TextEditingController();
  final TextEditingController unitpriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AdminPageBloc>().add(const ChangeAdminPage(1));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: const Text("Stage Edit"),
              centerTitle: true,
              backgroundColor: Colors.black,
              leading: IconButton(
                  onPressed: () {
                    context.read<AdminPageBloc>().add(const ChangeAdminPage(1));
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            ),
            body: BlocListener<AdminPageBloc, AdminPageState>(
                listener: (context, state) {
              if (state is StageEditPageStateSuccess) {
                context.read<AdminPageBloc>().add(const ChangeAdminPage(1));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text("Your updated success!"),
                        backgroundColor: Colors.green,
                      ));
                Navigator.pop(context);
              }
            }, child: SingleChildScrollView(
              child: BlocBuilder<AdminPageBloc, AdminPageState>(
                builder: (context, state) {
                  if (state is StageEditPageState) {
                    seatController.text = "${state.stageEditData.seats}";
                    unitpriceController.text = "${state.stageEditData.unitPrice}";
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Room ID: ${state.stageEditData.roomId}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              "Room name: ${state.stageEditData.roomName}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Update stage details",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                controller: seatController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return " * Required";
                                  }
                                  return null;
                                },
                                onTapOutside: (event) => FocusScope.of(context)
                                    .requestFocus(FocusNode()),
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                                decoration: InputDecoration(
                                    labelText: "Seats",
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.black),
                                    iconColor: Colors.black,
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintMaxLines: 1,
                                    hintText: "Change seat qty of room here",
                                    hintStyle: const TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(100),
                                        borderSide:
                                            const BorderSide(color: Colors.black))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                controller: unitpriceController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return " * Required";
                                  }
                                  return null;
                                },
                                onTapOutside: (event) => FocusScope.of(context)
                                    .requestFocus(FocusNode()),
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                                decoration: InputDecoration(
                                    labelText: "Unit Price",
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.black),
                                    iconColor: Colors.black,
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintMaxLines: 1,
                                    hintText: "Change price per seat here",
                                    hintStyle: const TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(100),
                                        borderSide:
                                            const BorderSide(color: Colors.black))),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bool validate = _formKey.currentState!.validate();
                                if (validate) {
                                  context.read<AdminPageBloc>().add(
                                      StageEditValidate(
                                          state.stageEditData.roomId,
                                          int.parse(seatController.text),
                                          int.parse(unitpriceController.text)));
                                  context
                                      .read<AnimalsBloc>()
                                      .add(const AnimalsGetList());
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.08,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100)),
                                child: const Text(
                                  "UPDATE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return LoadingWidget().loadingList(context);
                },
              ),
            ))),
      ),
    );
  }
}
