import 'package:flutter/material.dart';

class PaymentOption {

  Widget paymentOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: 60,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.account_balance,
              size: 30,
            )),
        Container(
            width: 60,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/images/icons/visa-master-logo.jpg",
              width: 30,
            )),
        Container(
            width: 60,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/images/icons/promtpay.png",
              width: 30,
            )),
        Container(
            width: 60,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/images/icons/truemoney.jpg",
              width: 30,
            )),
      ],
    );
  }
}
