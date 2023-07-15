import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/animals_bloc/animals_bloc.dart';
import 'package:zookeeper_app/models/animals_model.dart';
import 'package:zookeeper_app/screens/other/loading_widget.dart';

class AnimalShowList extends StatefulWidget {
  const AnimalShowList({super.key});

  @override
  State<AnimalShowList> createState() => _AnimalShowListState();
}

class _AnimalShowListState extends State<AnimalShowList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AnimalsBloc, AnimalsState>(
      listener: (context, state) {
        if (state is AnimalsFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${state.message}"),
            backgroundColor: Colors.grey,
          ));
        }
      },
      child: BlocBuilder<AnimalsBloc, AnimalsState>(
        builder: (context, state) {
          if (state is AnimalsLoading) {
            return LoadingWidget().loadingList(context);
          }
          if (state is AnimalsLoaded) {
            return animalComponents(context, state.animalsList);
          } else {
            return LoadingWidget().loadingList(context);
          }
        },
      ),
    );
  }

  Widget animalComponents(BuildContext context, List<Animals> animalList) {
    return CarouselSlider.builder(
      itemCount: animalList.length,
      options: CarouselOptions(
        initialPage: 0,
        autoPlay: false,
        enableInfiniteScroll: false,
        pageSnapping: true,
        aspectRatio: 1,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIndex) {
        return Stack(children: [
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          spreadRadius: 1,
                          blurRadius: 4)
                    ]),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${animalList[index].animalName}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: animalList[index].animalName ==
                                                  "Tiger"
                                              ? Colors.orange[700]
                                              : animalList[index].animalName ==
                                                      "Monkey"
                                                  ? Colors.brown[400]
                                                  : Colors.blue,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Spicies: ${animalList[index].spicies}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Type: ${animalList[index].type}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Duration: ${animalList[index].duration} min",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.black26,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${animalList[index].animalName} Stage Show",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: animalList[index].animalName ==
                                                  "Tiger"
                                              ? Colors.orange[700]
                                              : animalList[index].animalName ==
                                                      "Monkey"
                                                  ? Colors.brown[400]
                                                  : Colors.blue,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Show at ${animalList[index].roomName}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Price: ${animalList[index].unitPrice} THB/Seat",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 0,
                        blurRadius: 3)
                  ]),
              child: Image.asset(
                  animalList[index].animalName == "Tiger"
                      ? "assets/images/animal/tiger_img.jpg"
                      : animalList[index].animalName == "Monkey"
                          ? "assets/images/animal/monkey_img.jpg"
                          : "assets/images/animal/dolphin_img.jpg",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.3),
            ),
          )
        ]);
      },
    );
  }
}
