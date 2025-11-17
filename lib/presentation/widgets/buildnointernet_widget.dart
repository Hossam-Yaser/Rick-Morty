import 'package:flutter/material.dart';

import '../../constants/appcolors.dart';

Widget builNoInternet() {
  return Center(
    child: Container(
      color: Appcolors.mainGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/offline.png"),
          SizedBox(height: 20),
          Text(
            "There Is no Internet Connection !",
            style: TextStyle(
              fontSize: 22,
              color: Appcolors.darkSaga,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
