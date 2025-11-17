import 'package:flutter/material.dart';
import '../../constants/appcolors.dart';

Widget characterInfo(String title, String value) {
  return RichText(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,

    text: TextSpan(
      children: [
        TextSpan(
          text: title,
          style: TextStyle(
            color: Appcolors.darkSaga,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        TextSpan(
          text: value,
          style: TextStyle(color: Appcolors.darkSaga, fontSize: 18),
        ),
      ],
    ),
  );
}
