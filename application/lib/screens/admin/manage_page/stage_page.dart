import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/Routes/app_route.dart';

import '../../../bloc/admin_page_bloc/admin_page_bloc.dart';
import '../../../models/manage_model/stage_manage.dart';

class StagePage {
  Widget stageMangement(
      BuildContext context, List<Stagemanagemodel> getStageManage) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: getStageManage.length,
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
                          child: Stack(alignment: Alignment.center, children: [
                            Image.asset(
                              "assets/images/icons/circus-tent.png",
                              fit: BoxFit.fitHeight,
                              width: 100,
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                  width: 40,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Image.asset(getStageManage[index]
                                              .roomId ==
                                          1
                                      ? "assets/images/icons/number-one.png"
                                      : getStageManage[index].roomId == 2
                                          ? "assets/images/icons/number-2.png"
                                          : getStageManage[index].roomId == 3
                                              ? "assets/images/icons/number-3.png"
                                              : "assets/images/icons/number-one.png")),
                            ),
                          ])),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Room ID: ${getStageManage[index].roomId}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "Room name: ${getStageManage[index].roomName}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "Seat: ${getStageManage[index].seats}",
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "Price: ฿${getStageManage[index].unitPrice}/Seat",
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )
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
                            .add(StageEditPage(getStageManage[index]));
                        Navigator.pushNamed(context, AppRoute.stageEdit);
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
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Edit Stage",
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
