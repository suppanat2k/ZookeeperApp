import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/checkout_bloc/checkout_bloc.dart';
import '../../../bloc/round_bloc/round_bloc.dart';
import '../../other/loading_widget.dart';

class CheckoutPayment {

  Widget checkOutPayment(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, -2),
            blurRadius: 5)
      ]),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocBuilder<RoundBloc, RoundState>(
                    builder: (context, state) {
                      if (state is RoundPopUp) {
                        return InkWell(
                          onTap: () {
                            context.read<CheckoutBloc>().add(
                                DecrementCount(state.roundPopModel.roundSeq));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black),
                            child: Image.asset(
                              "assets/images/icons/minus.png",
                              width: 16,
                            ),
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black),
                          child: Image.asset(
                            "assets/images/icons/minus.png",
                            width: 16,
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      return Text(
                          state.countSeat.toString().padLeft(2, "0"),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500));
                    },
                  ),
                  BlocBuilder<RoundBloc, RoundState>(
                    builder: (context, state) {
                      if (state is RoundPopUp) {
                        return InkWell(
                          onTap: () {
                            context.read<CheckoutBloc>().add(
                                IncrementCount(state.roundPopModel.roundSeq));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black),
                            child: Image.asset(
                              "assets/images/icons/plus.png",
                              width: 16,
                            ),
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black),
                          child: Image.asset(
                            "assets/images/icons/plus.png",
                            width: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )),
          Expanded(
              flex: 3,
              child: BlocListener<CheckoutBloc, CheckoutState>(
                listener: (context, state) {
                  if (state is CheckoutLoading) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) =>
                          LoadingWidget().loadingList(context),
                    );
                  }
                  if (state is CheckoutFailed) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text("Please select your seats again."),
                      backgroundColor: Colors.red,
                    ));
                  }
                  if (state is CheckoutSuccess) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text("Your checkout success!"),
                      backgroundColor: Colors.green,
                    ));
                    context.read<RoundBloc>().add(const RoundGetList());
                    Navigator.pop(context);
                  }
                },
                child: BlocBuilder<RoundBloc, RoundState>(
                  builder: (context, state) {
                    if (state is RoundPopUp) {
                      if (state.roundPopModel.tkseats! >=
                          state.roundPopModel.seats!) {
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(
                            "CHECK OUT",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 20,
                            ),
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            context.read<CheckoutBloc>().add(
                                CheckoutCreatTicket(
                                    state.roundPopModel.roundSeq));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.black,
                            child: const Text(
                              "CHECK OUT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    return const CupertinoActivityIndicator();
                  },
                ),
              ))
        ],
      ),
    );
  }
  
}