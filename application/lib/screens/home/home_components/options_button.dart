import 'package:flutter/material.dart';
import 'package:zookeeper_app/screens/admin/admin_management.dart';
import 'package:zookeeper_app/screens/ticket/ticket.dart';

class OptionButton {
  final BuildContext context;
  OptionButton({required this.context});

  Route optionRoute(dynamic pages) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          pages,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget userOptionBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025,
          vertical: MediaQuery.of(context).size.height * 0.03),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(optionRoute(const TicketScreen()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                    blurRadius: 4)
              ]),
          child: const Center(
              child: Text(
            "BUY TICKETS",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
        ),
      ),
    );
  }

  Widget adminOptionBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025,
          vertical: MediaQuery.of(context).size.height * 0.03),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(optionRoute(const AdminManagement()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                    blurRadius: 4)
              ]),
          child:
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.settings,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Admin Management",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ]),
        ),
      ),
    );
  }
}
