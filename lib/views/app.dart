import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:survey_app/views/starter_view_widget.dart';
import 'package:survey_app/views/survey_view_widget.dart';
import 'package:survey_app/views/thank_view_widget.dart';
import 'package:survey_app/widgets/helper.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.redAccent,
          scaffoldBackgroundColor: Colors.white),
      home: HomeViewWidget(),
    );
  }
}

class HomeViewWidget extends StatefulWidget {
  @override
  HomeViewWidgetState createState() {
    return HomeViewWidgetState();
  }
}

class HomeViewWidgetState extends State<HomeViewWidget> {
  int curIndex = -1;
  List questionairs = [];
  Map surveyResult = {};

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
      child: Container(child: loadStartupView()),
    ));
  }

  void loadJson() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/data.json");
    setState(() => questionairs = json.decode(data));
  }

  Widget loadStartupView() {
    if (curIndex != -1) {
      return curIndex == questionairs.length ? thankWidget() : getSurveyPages();
    } else {
      return starterSurveyWidget();
    }
  }

  Widget getSurveyPages() {
    return SurveyViewWidget(
      curIndex: this.curIndex,
      questionairs: this.questionairs,
      surveyResult: this.surveyResult,
      nextQuestionCallback: () => this.nextQuestion(),
      previousQuestionCallback: () => this.previousQuestion(),
    );
  }

  Widget thankWidget() {
    return ThankViewWidget(callback: () {
      setState(() {
        surveyResult = {};
        curIndex = -1;
      });
    });
  }

  Widget starterSurveyWidget() {
    return StarterViewWidget(onSelected: (value) {
      surveyResult[0] = value;
      nextQuestion();
    });
  }

  nextQuestion() {
    print("hello World");
    if (this.surveyResult[this.curIndex + 1] == null) {
      Helper.alert(context, "Error", "Please rate befor moving on");
    } else {
      setState(() => this.curIndex += 1);
    }
  }

  previousQuestion() {
    setState(() => this.curIndex -= 1);
  }
}
