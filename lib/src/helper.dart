import 'package:flutter/material.dart';

class Helper {
  Helper._();

  static const Color COLOR_PRIMARY = Color(0xFFD12A2F);
  static const Color COLOR_DARK = Color(0xFF253840);

  static const TextStyle headerKhmer = TextStyle(
    fontFamily: 'Khmer',
    fontWeight: FontWeight.w500,
    fontSize: 25,
    letterSpacing: 0.27,
    color: COLOR_PRIMARY,
  );

  static const TextStyle titleKhmer = TextStyle(
    fontFamily: 'Khmer',
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: 0.27,
    color: COLOR_DARK,
  );

  static const TextStyle titleWhite = TextStyle(
      fontFamily: 'Khmer',
      fontWeight: FontWeight.w500,
      fontSize: 20,
      letterSpacing: 0.27,
      color: Colors.white);

  static const TextStyle titleEng = TextStyle(
    fontFamily: 'English',
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: 0.27,
    color: COLOR_DARK,
  );

  static const TextStyle subtitleEng = TextStyle(
    fontFamily: 'English',
    fontWeight: FontWeight.w500,
    fontSize: 15,
    letterSpacing: 0.27,
    color: COLOR_DARK,
  );

  static const TextStyle subtitleKhmer = TextStyle(
    fontFamily: 'Khmer',
    fontWeight: FontWeight.w500,
    fontSize: 13,
    letterSpacing: 0.27,
    color: COLOR_DARK,
  );

  static Widget questionLabelInKhmerEng(String khmer, String english) {
    return Column(children: [
      Center(
          child: Container(
              margin: EdgeInsets.only(top: 70.0),
              child: Text(khmer,
                  style: Helper.titleKhmer, textAlign: TextAlign.center))),
      Center(
          child: Container(
              margin: EdgeInsets.only(top: 5.0, bottom: 20),
              child: Text(english,
                  style: Helper.titleEng, textAlign: TextAlign.center))),
    ]);
  }

    static alert(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }

  static Widget button(String title, Color color, VoidCallback callback) {
    return InkWell(
        onTap: () => callback(),
        child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(top: 20, bottom: 20, right: 50, left: 50),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Text(title, style: Helper.titleWhite)));
  }
}
