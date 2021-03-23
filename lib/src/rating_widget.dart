import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:survey_app/src/helper.dart';

// ignore: must_be_immutable
class RatingWidget extends StatefulWidget {
  String overallStatus;
  double overall;

  String khmerQestion;
  String engQestion;

  Function (double) callback;



  RatingWidget(
      {Key? key,
      required this.khmerQestion,
      required this.engQestion,
      required this.overallStatus,
      required this.overall,
      required this.callback
      });

  @override
  State<StatefulWidget> createState() {
    return _RatingStateWidget();
  }
}

class _RatingStateWidget extends State<RatingWidget> {
 
    bool visible = false;

  @override
  void initState() {
    super.initState();
    getOverallStatus(widget.overall);
    Future.delayed(Duration(milliseconds: 100), () => setState(() => visible = true));
  }

  @override
  Widget build(BuildContext context) {
  
    return Expanded(
      child: AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            margin: EdgeInsets.only(top: 34.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Helper.questionLabelInKhmerEng(
                    widget.khmerQestion, widget.engQestion),
                SizedBox(height: 50),
                Text(
                  widget.overallStatus,
                  style: TextStyle(
                      color: Helper.COLOR_PRIMARY,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Center(
                    child: RatingBar.builder(
                  initialRating: widget.overall,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Helper.COLOR_PRIMARY,
                  ),
                  onRatingUpdate: (rating) {
                    widget.callback(rating);
                    setState(() {
                      widget.overall = rating.round().toDouble();
                      getOverallStatus(widget.overall);
                    });
                  },
                ))
              ],
            ),
          )),
    );
  }

  getOverallStatus(double overall) {
    switch (overall.toInt()) {
      case 1:
        widget.overallStatus = 'Bad';
        break;
      case 2:
        widget.overallStatus = 'Normal';
        break;
      case 3:
        widget.overallStatus = 'Good';
        break;
      case 4:
        widget.overallStatus = 'Very Good';
        break;
      default:
        widget.overallStatus = 'Excellent';
        break;
    }
  }
}
