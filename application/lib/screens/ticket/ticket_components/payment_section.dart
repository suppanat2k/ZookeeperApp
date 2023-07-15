import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zookeeper_app/bloc/checkout_bloc/checkout_bloc.dart';
import 'package:zookeeper_app/screens/ticket/ticket_components/paymentoption.dart';

class PaymentSection {
  final currency = NumberFormat("#,##0.00", "en_US");

  Widget paymentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Payment option",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        PaymentOption().paymentOption(),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Check out details",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                "Seat:",
                style: TextStyle(color: Colors.black87, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  return Text(
                    "${state.countSeat}",
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
              const Text(
                "Discount:",
                style: TextStyle(color: Colors.black87, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                "-",
                style: TextStyle(color: Colors.black87, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                "Total price:",
                style: TextStyle(color: Colors.black87, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  return Text(
                    "฿${currency.format(state.countPrice)}",
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
