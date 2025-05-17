import "package:flutter/material.dart";

import "../constants/colors.dart";

Widget buildEmptyScreenText({required text, required subtitle}) {
  return Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.hourglass_empty_outlined, size: 100.0, color: lightGray),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(color: lightGray, fontSize: 16),
          children: [
            TextSpan(
              text: "\n$text",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: gray)),
            TextSpan(text: "\n\n$subtitle")
            ]
          )
        )
      ]
    )
  );

}