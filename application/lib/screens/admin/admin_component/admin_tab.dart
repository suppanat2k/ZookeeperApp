import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/admin_page_bloc/admin_page_bloc.dart';

class AdminComponent {
  Widget tabManage(BuildContext context,int pageIndex) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                context.read<AdminPageBloc>().add(const ChangeAdminPage(0));
              },
              child: AnimatedContainer(
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                    color: pageIndex == 0 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(3)),
                child: Text(
                  "Animals",
                  style: TextStyle(
                      color: pageIndex == 0 ? Colors.black : Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                context.read<AdminPageBloc>().add(const ChangeAdminPage(1));
              },
              child: AnimatedContainer(
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                    color: pageIndex == 1 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(3)),
                child: Text(
                  "Stage",
                  style: TextStyle(
                      color: pageIndex == 1 ? Colors.black : Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                context.read<AdminPageBloc>().add(const ChangeAdminPage(2));
              },
              child: AnimatedContainer(
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                    color: pageIndex == 2 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(3)),
                child: Text(
                  "RoundShow",
                  style: TextStyle(
                      color: pageIndex == 2 ? Colors.black : Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}