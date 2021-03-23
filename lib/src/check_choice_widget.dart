import 'package:flutter/material.dart';



class CheckBoxChoiceWidget extends StatefulWidget {

  List thirdQuestionList;

  CheckBoxChoiceWidget({Key? key, required this.thirdQuestionList});

  @override
  State<StatefulWidget> createState() {
    return _CheckBoxChoiceWidget();
  }
  
}

class _CheckBoxChoiceWidget extends State<CheckBoxChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 3'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('What do you like about our service?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 213.0,
                      child: Card(
                        child: Column(
                          children: List.generate(widget.thirdQuestionList.length,
                              (int index) {
                            ThirdQuestion question = widget.thirdQuestionList[index];
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTapUp: (detail) {
                                    setState(() {
                                      question.isSelected =
                                          !question.isSelected;
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    color: question.isSelected
                                        ? Colors.orangeAccent.withAlpha(100)
                                        : Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                            activeColor: Colors.orangeAccent,
                                            value: question.isSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                question.isSelected = value!;
                                              });
                                            }),
                                        Text(question.displayContent)
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: index < widget.thirdQuestionList.length
                                      ? 1.0
                                      : 0.0,
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
      
    );
  }
  
}

class ThirdQuestion {
  final String displayContent;
  bool isSelected;

  ThirdQuestion(this.displayContent, this.isSelected);
}