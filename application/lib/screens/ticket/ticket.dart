import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zookeeper_app/Routes/app_route.dart';
import 'package:zookeeper_app/bloc/checkout_bloc/checkout_bloc.dart';
import 'package:zookeeper_app/bloc/round_bloc/round_bloc.dart';

import '../../models/round_model.dart';
import '../other/loading_widget.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              title: const Text("BUY TICKETS"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<RoundBloc>().add(const RoundGetList());
                      searchController.text = "";
                    },
                    icon: const Icon(Icons.refresh))
              ],
              leading: IconButton(
                  onPressed: () {
                    context.read<RoundBloc>().add(const RoundGetList());
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
              bottom: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height * 0.08),
                  child: searchRoundList(context)),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  filterAnimal(context),
                  BlocListener<RoundBloc, RoundState>(
                    listener: (context, state) {
                      if (state is RoundFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("${state.message}"),
                          backgroundColor: Colors.grey,
                        ));
                      }
                    },
                    child: BlocBuilder<RoundBloc, RoundState>(
                      builder: (context, state) {
                        if (state is RoundLoading) {
                          return LoadingWidget().loadingList(context);
                        }
                        if (state is RoundLoaded) {
                          return roundList(context, state.roundList);
                        } else {
                          return LoadingWidget().loadingList(context);
                        }
                      },
                    ),
                  )
                ],
              ),
            )));
  }

  Widget filterAnimal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            onTap: () {
              context.read<RoundBloc>().add(const SearchRoundEvent("Tiger"));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4)
                  ]),
              child: Image.asset(
                "assets/images/animal/tiger_img_icon.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            onTap: () {
              context.read<RoundBloc>().add(const SearchRoundEvent("Monkey"));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        blurRadius: 4)
                  ]),
              child: Image.asset(
                "assets/images/animal/monkey_img_icon.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            onTap: () {
              context.read<RoundBloc>().add(const SearchRoundEvent("Dolphin"));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        blurRadius: 4)
                  ]),
              child: Image.asset(
                "assets/images/animal/dolphin_img_icon.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchRoundList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(FocusNode()),
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black),
        controller: searchController,
        onChanged: (value) => context
            .read<RoundBloc>()
            .add(SearchRoundEvent(searchController.text)),
        decoration: InputDecoration(
            iconColor: Colors.black,
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.black,
            hintMaxLines: 1,
            hintText: "eg. Type, Name or Room",
            hintStyle: const TextStyle(color: Colors.black45,fontSize: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none)),
      ),
    );
  }

  Widget roundList(BuildContext context, List<Roundshow> roundList) {
    //format time
    String formatTime(String? timeString) {
      final parsedTime = DateTime.parse('1970-01-01 $timeString');
      final formattedTime = DateFormat('h:mm a').format(parsedTime);
      return formattedTime;
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: roundList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: InkWell(
            onTap: () {
              context.read<CheckoutBloc>().add(ResetCount(roundList[index].roundSeq));
              context
                  .read<RoundBloc>()
                  .add(RoundGetPopModel(roundList[index].roundSeq));
              Navigator.pushNamed(context, AppRoute.ticketPop);
            },
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          blurRadius: 4)
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Image.asset(
                          roundList[index].animalName == "Tiger"
                              ? "assets/images/icons/tiger_icon.png"
                              : roundList[index].animalName == "Monkey"
                                  ? "assets/images/icons/monkey_icon.png"
                                  : "assets/images/icons/dolphin_icon.png",
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              color: Colors.black,
                              child: Text(
                                "${roundList[index].roundName}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Show time: ${formatTime(roundList[index].timeShow)}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Animal: ${roundList[index].animalName}",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Stage: ${roundList[index].roomName}",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Price: ${roundList[index].unitPrice} THB/Seat",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ))
                  ],
                )),
          ),
        );
      },
    );
  }
}
