import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:survey_app/src/question_model.dart';
import 'package:survey_app/src/thank_widget.dart';

import 'helper.dart';
import 'starter_widget.dart';
import 'multiple_choice_widget.dart';
import 'rating_widget.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.redAccent,
          scaffoldBackgroundColor: Colors.white),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  double rate = 0.0;
  String rateStatus = "";

  int curIndex = -1;
  List questionairs = [];

  Map result = {};

  @override
  void initState() {
    super.initState();
    this.loadJson();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: curIndex != -1
            ? (curIndex == questionairs.length ? thankWidget() : getPages())
            : starterWidget(),
      ),
    ));
  }

  loadJson() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("images/data.json");
    setState(() => questionairs = json.decode(data));
  }

  thankWidget() {
    return ThankWidget(callback: () {
      setState(() {
       result = {};
        curIndex = -1;
      });
    });
  }

  starterWidget() {
    return StarterWidget(onSelected: (value) {
      result[0] = value;
      nextQuestion();
    });
  }

  Widget getPages() {
    return Stack(children: [
      Positioned(
          bottom: MediaQuery.of(context).size.height / 2,
          left: 20,
          child: InkWell(
              onTap: () => previousQuestion(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.arrow_back_ios),
              ))),
      Positioned(
          bottom: MediaQuery.of(context).size.height / 2,
          right: 20,
          child: InkWell(
              onTap: () => nextQuestion(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.arrow_forward_ios),
              ))),
      Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset("images/bush.jpg", width: 150)),
      Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset("images/bush_rev.jpg", width: 150)),
      body()
    ]);
  }

  Widget body() {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double theWidth = logicalSize.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 10.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(this.questionairs.length, (int index) {
                return Container(
                  decoration: BoxDecoration(
                    color:
                        index == curIndex ? Helper.COLOR_PRIMARY : Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                  height: 10.0,
                  width: (theWidth - 32.0 - 15.0) / 4.0,
                  margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                );
              }),
            ),
          ),
          questionByIndex(),
        ],
      ),
    );
  }

  Widget questionByIndex() {
    var questionair = Questionair.fromJson(questionairs[curIndex]);

    if (questionair.type == 'rating') {
      return RatingWidget(
          khmerQestion: questionair.questionKh,
          engQestion: questionair.questionEn,
          rate: rate,
          rateStatus: rateStatus,
          callback: (value) {
            result[curIndex + 1] = value;
          });
    } else {
      return MultipleChoiceWidget(
          questionair: questionair,
          callback: (value) {
            result[curIndex + 1] = value;
          });
    }
  }

  nextQuestion() {
 if (result[curIndex + 1] == null) {
      Helper.alert(context, "Error", "Please rate befor moving on");
    } else {
      setState(() => curIndex += 1);
    }
  }

  previousQuestion() {
    setState(() => curIndex -= 1);
  }
}
