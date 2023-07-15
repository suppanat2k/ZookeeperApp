import 'package:flutter/cupertino.dart';

class LoadingWidget {
  Widget loadingList(BuildContext context) {
    // return Center(child: Lottie.asset("assets/lotties/Loading.json",
    //         width: MediaQuery.of(context).size.width * 0.8,
    //         height: MediaQuery.of(context).size.width * 0.8));
    return const Center(child: CupertinoActivityIndicator(radius: 20,));
  }
}
