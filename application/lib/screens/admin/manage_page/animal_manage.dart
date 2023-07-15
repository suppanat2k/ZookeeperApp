import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/Routes/app_route.dart';

import '../../../bloc/admin_page_bloc/admin_page_bloc.dart';
import '../../../models/manage_model/animal_manage_model.dart';

class AnimalPage {
  Widget animalMangement(
      BuildContext context, List<Animalmanagemodel> getAnimalManage) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: getAnimalManage.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 4)
                ]),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: Image.asset(
                              getAnimalManage[index].animalName == "Tiger"
                                  ? "assets/images/animal/tiger_img_icon.png"
                                  : getAnimalManage[index].animalName ==
                                          "Monkey"
                                      ? "assets/images/animal/monkey_img_icon.png"
                                      : "assets/images/animal/dolphin_img_icon.png",
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Animal ID: ${getAnimalManage[index].animalId}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "Animal name: ${getAnimalManage[index].animalName}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "Spicies: ${getAnimalManage[index].spicies}",
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "Type: ${getAnimalManage[index].type}",
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "Duration: ${getAnimalManage[index].duration} min",
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        context
                            .read<AdminPageBloc>()
                            .add(AnimalEditPage(getAnimalManage[index]));
                        Navigator.pushNamed(context, AppRoute.animalEdit);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10,),
                            Text(
                              "Edit Information",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
