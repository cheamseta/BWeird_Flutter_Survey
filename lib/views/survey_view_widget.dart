import 'package:flutter/material.dart';
import 'package:survey_app/models/question_model.dart';
import 'dart:ui' as ui;

import 'package:survey_app/widgets/helper.dart';
import 'package:survey_app/widgets/multiple_choice_widget.dart';
import 'package:survey_app/widgets/rating_widget.dart';

class SurveyViewWidget extends StatefulWidget {
  int curIndex;
  List questionairs;
  Map surveyResult;

  final VoidCallback nextQuestionCallback;
  final VoidCallback previousQuestionCallback;

  SurveyViewWidget(
      {required this.curIndex,
      required this.questionairs,
      required this.surveyResult,
      required this.nextQuestionCallback,
      required this.previousQuestionCallback});

  @override
  State<StatefulWidget> createState() {
    return _SurveyViewWidget();
  }
}

class _SurveyViewWidget extends State<SurveyViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          bottom: MediaQuery.of(context).size.height / 2,
          left: 20,
          child: InkWell(
              onTap: () {
                widget.previousQuestionCallback();
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.arrow_back_ios),
              ))),
      Positioned(
          bottom: MediaQuery.of(context).size.height / 2,
          right: 20,
          child: InkWell(
              onTap: () {
                widget.nextQuestionCallback();
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.arrow_forward_ios),
              ))),
      Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset("assets/images/bush.jpg", width: 150)),
      Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset("assets/images/bush_rev.jpg", width: 150)),
      body()
    ]);
  }

  Widget body() {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double theWidth = logicalSize.width;

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 10.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(widget.questionairs.length, (int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: index == widget.curIndex
                        ? Helper.COLOR_PRIMARY
                        : Colors.grey,
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
    );
  }

  Widget questionByIndex() {
    var questionair =
        Questionair.fromJson(widget.questionairs[widget.curIndex]);

    if (questionair.type == 'rating') {
      return RatingWidget(
          khmerQestion: questionair.questionKh,
          engQestion: questionair.questionEn,
          rate: 0,
          rateStatus: "",
          callback: (value) {
            widget.surveyResult[widget.curIndex + 1] = value;
          });
    } else {
      return MultipleChoiceWidget(
          questionair: questionair,
          callback: (value) {
            widget.surveyResult[widget.curIndex + 1] = value;
          });
    }
  }
}
