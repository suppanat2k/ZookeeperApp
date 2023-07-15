import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zookeeper_app/bloc/admin_page_bloc/admin_page_bloc.dart';
import 'package:zookeeper_app/screens/other/loading_widget.dart';

class RoundEditPageScreen extends StatefulWidget {
  const RoundEditPageScreen({super.key});

  @override
  State<RoundEditPageScreen> createState() => _RoundEditPageScreenState();
}

class _RoundEditPageScreenState extends State<RoundEditPageScreen> {
  //format time
  String formatTime(String? timeString) {
    if (timeString == null) {}
    final parsedTime = DateTime.parse('1970-01-01 $timeString');
    final formattedTime = DateFormat('hh:mm a').format(parsedTime);
    return formattedTime;
  }

  final List<String> timeItems = [
    '00:00:00',
    '01:00:00',
    '02:00:00',
    '03:00:00',
    '04:00:00',
    '05:00:00',
    '06:00:00',
    '07:00:00',
    '08:00:00',
    '09:00:00',
    '10:00:00',
    '11:00:00',
    '12:00:00',
    '13:00:00',
    '14:00:00',
    '15:00:00',
    '16:00:00',
    '17:00:00',
    '18:00:00',
    '19:00:00',
    '20:00:00',
    '21:00:00',
    '22:00:00',
    '23:00:00',
  ];
  String? selectedTimeRound1;
  String? selectedTimeRound2;
  String? selectedTimeRound3;
  bool validate = true;
  bool validateNull = true;

  void setTime(String value, int index) {
    setState(() {
      switch (index) {
        case 0:
          selectedTimeRound1 = value;
          break;
        case 1:
          selectedTimeRound2 = value;
          break;
        case 2:
          selectedTimeRound3 = value;
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AdminPageBloc>().add(const ChangeAdminPage(2));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: const Text("Round Edit"),
              centerTitle: true,
              backgroundColor: Colors.black,
              leading: IconButton(
                  onPressed: () {
                    context.read<AdminPageBloc>().add(const ChangeAdminPage(2));
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            ),
            body: BlocListener<AdminPageBloc, AdminPageState>(
                listener: (context, state) {
              if (state is RoundEditPageStateSuccess) {
                context.read<AdminPageBloc>().add(const ChangeAdminPage(2));
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
                  if (state is RoundEditPageState) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Room name: ${state.roundEditData[0].roomName}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            "Animal: ${state.roundEditData[0].animalName}",
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
                          Row(
                            children: [
                              const Icon(
                                Icons.edit,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Update show time in ${state.roundEditData[0].roomName}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(20)),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.roundEditData.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${state.roundEditData[index].roundName}",
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Current",
                                        style: TextStyle(
                                            color: Colors.blue[700],
                                            fontSize: 12),
                                      ),
                                      Text(
                                        formatTime(state.roundEditData[index].timeShow),
                                        style: TextStyle(
                                            color: Colors.blue[700],
                                            fontSize: 12),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      index == 0
                                          ? selectTimeRound(timeItems,
                                              selectedTimeRound1, setTime, index)
                                          : index == 1
                                              ? selectTimeRound(
                                                  timeItems,
                                                  selectedTimeRound2,
                                                  setTime,
                                                  index)
                                              : selectTimeRound(
                                                  timeItems,
                                                  selectedTimeRound3,
                                                  setTime,
                                                  index),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          validateNull
                              ? Container()
                              : const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Text(
                                    "** You need to choose time in select field",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14),
                                  ),
                                ),
                          validate
                              ? Container()
                              : const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Text(
                                    "** You cannot choose duplicate times",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14),
                                  ),
                                ),
                          InkWell(
                            onTap: () {
                              if (selectedTimeRound1 != null &&
                                  selectedTimeRound2 != null &&
                                  selectedTimeRound3 != null) {
                                if (selectedTimeRound1 != selectedTimeRound2 &&
                                    selectedTimeRound1 != selectedTimeRound3 &&
                                    selectedTimeRound2 != selectedTimeRound3) {
                                  setState(() {
                                    validate = true;
                                    validateNull = true;
                                  });
                                  //change times
                                  context.read<AdminPageBloc>().add(
                                      RoundEditValidate(
                                          state.roundEditData[0].roomId,
                                          selectedTimeRound1!,
                                          selectedTimeRound2!,
                                          selectedTimeRound3!,
                                          state.roundEditData[0].roundSeq,
                                          state.roundEditData[1].roundSeq,
                                          state.roundEditData[2].roundSeq));
                                } else {
                                  setState(() {
                                    validateNull = true;
                                    validate = false;
                                  });
                                }
                              } else {
                                setState(() {
                                  validateNull = false;
                                });
                              }
    
                              // context.read<AdminPageBloc>().add(
                              //     StageEditValidate(
                              //         state.stageEditData.roomId,
                              //         int.parse(seatController.text),
                              //         int.parse(unitpriceController.text)));
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
                    );
                  }
                  return LoadingWidget().loadingList(context);
                },
              ),
            ))),
      ),
    );
  }

  Widget selectTimeRound(
      List<String> items, String? selectedValue, Function setTime, int index) {
    //format time
    String formatTime(String? timeString) {
      if (timeString == null) {}
      final parsedTime = DateTime.parse('1970-01-01 $timeString');
      final formattedTime = DateFormat('hh:mm a').format(parsedTime);
      return formattedTime;
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          isExpanded: true,
          hint: Text(
            'Select Time',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      formatTime(item),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setTime(value, index);
          },
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 40,
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
  }
}
