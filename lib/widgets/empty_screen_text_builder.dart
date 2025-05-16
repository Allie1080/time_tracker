import "package:flutter/material.dart";

import "../constants/colors.dart";

Widget buildEmptyScreenText({required text, required subtitle}) {
  return Center(
  child: RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: const TextStyle(color: gray, fontSize: 16),
      children: [
        TextSpan(
          text: text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        TextSpan(text: "\n$subtitle")
        ]
      )
    )
  );

}