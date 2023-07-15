import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/admin_page_bloc/admin_page_bloc.dart';
import 'package:zookeeper_app/bloc/animals_bloc/animals_bloc.dart';
import 'package:zookeeper_app/screens/other/loading_widget.dart';

class AnimalEditPageScreen extends StatefulWidget {
  const AnimalEditPageScreen({super.key});

  @override
  State<AnimalEditPageScreen> createState() => _AnimalEditPageScreenState();
}

class _AnimalEditPageScreenState extends State<AnimalEditPageScreen> {
  final TextEditingController spiciesController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AdminPageBloc>().add(const ChangeAdminPage(0));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: const Text("Animal Edit"),
              centerTitle: true,
              backgroundColor: Colors.black,
              leading: IconButton(
                  onPressed: () {
                    context.read<AdminPageBloc>().add(const ChangeAdminPage(0));
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            ),
            body: BlocListener<AdminPageBloc, AdminPageState>(
                listener: (context, state) {
              if (state is AnimalEditPageStateSuccess) {
                context.read<AdminPageBloc>().add(const ChangeAdminPage(0));
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
                  if (state is AnimalEditPageState) {
                    spiciesController.text =
                        state.animalEditData.spicies.toString();
                    typeController.text = state.animalEditData.type.toString();
                    durationController.text =
                        state.animalEditData.duration.toString();
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Animal ID: ${state.animalEditData.animalId}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              "Animal name: ${state.animalEditData.animalName}",
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
                                    "Update animals information",
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
                                textInputAction: TextInputAction.next,
                                controller: spiciesController,
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
                                    labelText: "Animal spicies",
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.black),
                                    iconColor: Colors.black,
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintMaxLines: 1,
                                    hintText: "Change spicies of animal here",
                                    hintStyle: const TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: Colors.black))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: typeController,
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
                                    labelText: "Animal type",
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.black),
                                    iconColor: Colors.black,
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintMaxLines: 1,
                                    hintText: "Change type of animal here",
                                    hintStyle: const TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: Colors.black))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: durationController,
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
                                    labelText: "Duration show",
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.black),
                                    iconColor: Colors.black,
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintMaxLines: 1,
                                    hintText:
                                        "Change duration show of animal here",
                                    hintStyle: const TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: Colors.black))),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bool validate =
                                    _formKey.currentState!.validate();
                                if (validate) {
                                  context.read<AdminPageBloc>().add(
                                      AnimalEditValidate(
                                          state.animalEditData.animalId,
                                          spiciesController.text,
                                          typeController.text,
                                          int.parse(durationController.text)));
                                  context
                                      .read<AnimalsBloc>()
                                      .add(const AnimalsGetList());
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
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
