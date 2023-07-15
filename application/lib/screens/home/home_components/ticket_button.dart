import 'package:flutter/material.dart';
import 'package:zookeeper_app/Routes/app_route.dart';
import 'package:zookeeper_app/screens/pocket_ticket/my_ticket_screen.dart';

class TicketButton {
  final BuildContext context;
  TicketButton({required this.context});

  Route myticketRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const MyTicketList(),
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

  Widget userTicketBtn() {
    return InkWell(
      onTap: () {
        Navigator.push(context, myticketRoute());
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                  blurRadius: 4)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icons/tickets.png",
              width: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "MY TICKETS",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  Widget adminTicketBtn() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.qrScanner);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                  blurRadius: 4)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icons/qr_scan.png",
              width: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "SCAN TICKET",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
