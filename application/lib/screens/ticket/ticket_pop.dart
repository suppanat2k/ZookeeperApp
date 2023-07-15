import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zookeeper_app/bloc/authenticate_bloc/authenticate_bloc.dart';
import 'package:zookeeper_app/bloc/round_bloc/round_bloc.dart';
import 'package:zookeeper_app/screens/ticket/ticket_components/checkout_payment.dart';
import 'package:zookeeper_app/screens/ticket/ticket_components/payment_section.dart';
import 'package:zookeeper_app/screens/ticket/ticket_components/promotion.dart';
import 'package:zookeeper_app/screens/ticket/ticket_components/round_detail.dart';

import '../other/loading_widget.dart';

class TicketPopUp extends StatelessWidget {
  const TicketPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<RoundBloc>().add(const RoundGetList());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Payment details"),
              centerTitle: true,
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    context.read<RoundBloc>().add(const RoundGetList());
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headRoundDetailComponent(context),
                  roundDetailComponent(context),
                  PromotionRedeem().promotionRedeem(context),
                  PaymentSection().paymentSection(context)
                ],
              ),
            ),
            bottomNavigationBar: CheckoutPayment().checkOutPayment(context)),
      ),
    );
  }

  Widget roundDetailComponent(BuildContext context) {
    return BlocBuilder<RoundBloc, RoundState>(
      builder: (context, state) {
        if (state is RoundLoading) {
          return LoadingWidget().loadingList(context);
        }
        if (state is RoundPopUp) {
          return RoundDetail().roundDetail(state.roundPopModel);
        }
        return LoadingWidget().loadingList(context);
      },
    );
  }

  Widget headRoundDetailComponent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return Text("Hi ${state.username}!",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 30,
                      fontWeight: FontWeight.bold));
            } else {
              return const LinearProgressIndicator();
            }
          },
        ),
        const Text(
          "Let's check details to confirm and payment.",
          style: TextStyle(
            color: Colors.black26,
            fontSize: 14,
          ),
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
