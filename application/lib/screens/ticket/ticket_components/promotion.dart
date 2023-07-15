import 'package:flutter/material.dart';

class PromotionRedeem {
  Widget promotionRedeem(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              "assets/images/icons/promotion.png",
              width: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Redeem Promotion Code",
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
          height: 5,
        ),
        TextFormField(
          onTapOutside: (event) =>
              FocusScope.of(context).requestFocus(FocusNode()),
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              iconColor: Colors.black,
              fillColor: Colors.white,
              filled: true,
              hintMaxLines: 1,
              hintText: "Enter your code here",
              hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none)),
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
