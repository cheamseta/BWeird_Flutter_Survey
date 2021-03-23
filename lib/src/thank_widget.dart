import 'package:flutter/material.dart';
import 'package:survey_app/src/helper.dart';

class ThankWidget extends StatefulWidget {

  VoidCallback callback;
  ThankWidget({Key? key, required this.callback});

  @override
  State<StatefulWidget> createState() {
    return _ThankWidget();
  }
}

class _ThankWidget extends State<ThankWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: 50,
          left: 10,
          child: Image.asset("images/title.jpg",
              width: 200,
              color: Color.fromRGBO(255, 255, 255, 0.3),
              colorBlendMode: BlendMode.modulate)),
      Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset("images/bush.jpg", width: 150)),
      Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset("images/bush_rev.jpg", width: 150)),
      body(),
    ]);
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('សូមអរគុណដែលបានផ្តល់ មតិយោបល់ ដល់ផ្សារការ៉ុត',
              style: Helper.headerKhmer, textAlign: TextAlign.left),
          Helper.questionLabelInKhmerEng(
              'តើអ្នកចង់បន្ត ផ្តល់មតិបន្ថែម?', 'Do you want to add more?'),
           Image.asset(
            "images/hi5.gif",
            width: 150.0,
            height: 150.0,
          ),
          Helper.button("DONE", Helper.COLOR_DARK, () => widget.callback())
        ],
      ),
    );
  }
}
