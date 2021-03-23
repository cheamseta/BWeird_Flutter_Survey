import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey_app/src/helper.dart';
import 'package:survey_app/src/question_model.dart';

class MultipleChoiceWidget extends StatefulWidget {

  Function(String) callback;
  Questionair questionair;

  MultipleChoiceWidget({Key? key, required this.questionair, required this.callback});

  @override
  State<StatefulWidget> createState() {
    return _MultipleChoiceWidget();
  }
}

class _MultipleChoiceWidget extends State<MultipleChoiceWidget> {
  String selected = "";

  @override
  Widget build(BuildContext context) {
    List multipleChoices = widget.questionair.answers!;

    String khmerQ = widget.questionair.questionKh;
    String englishQ = widget.questionair.questionEn;

    return Expanded(
        child: Center(
            child: Column(children: [
      Helper.questionLabelInKhmerEng(khmerQ, englishQ),
      Container(
          height: 300,
          width: 400,
          child: ListView.builder(
              itemCount: multipleChoices.length,
              itemBuilder: (BuildContext context, int index) {
                final answer = multipleChoices[index];
                return RadioListTile(
                    title: Text(
                      answer,
                      style: Helper.titleEng,
                    ),
                    value: answer,
                    groupValue: selected,
                    onChanged: (dynamic? value) {
                      widget.callback(value.toString());
                      setState(() => selected = value.toString());
                       print(selected);
                    });
              }))
    ])));
  }
}
