import 'package:zookeeper_app/repositiories/auth_repositories.dart';
import 'package:zookeeper_app/screens/admin/admin_management.dart';
import 'package:zookeeper_app/screens/admin/manage_page/edit_page/animal_edit.dart';
import 'package:zookeeper_app/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:zookeeper_app/screens/login/login_screen.dart';
import 'package:zookeeper_app/screens/pocket_ticket/my_ticket_popup.dart';
import 'package:zookeeper_app/screens/scanner_qr/qrcode_scan.dart';
import 'package:zookeeper_app/screens/ticket/ticket.dart';
import 'package:zookeeper_app/screens/ticket/ticket_pop.dart';

import '../screens/admin/manage_page/edit_page/round_edit.dart';
import '../screens/admin/manage_page/edit_page/stage_edit.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';
  static const ticket = 'ticket';
  static const ticketPop = 'ticketPop';
  static const myticketPop = 'myticketPop';
  static const qrScanner = 'qrScanner';
  static const adminManage = 'adminManage';
  static const animalEdit = 'animalEdit';
  static const stageEdit = 'stageEdit';
  static const roundEdit = 'roundEdit';

  final _route = <String, WidgetBuilder>{
    home: (context) => const HomeScreen(),
    login: (context) => LoginScreen(
          userRepositories: UserRepositories(),
        ),
    ticket: (context) => const TicketScreen(),
    ticketPop: (context) => const TicketPopUp(),
    myticketPop: (context) => const MyTicketPopUp(),
    qrScanner: (context) => const QRScanner(),
    adminManage: (context) => const AdminManagement(),
    animalEdit: (context) => const AnimalEditPageScreen(),
    stageEdit: (context) => const StageEditPageScreen(),
    roundEdit:(context) => const RoundEditPageScreen()
  };

  get getAll => _route;
}
