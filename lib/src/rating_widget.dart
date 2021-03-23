import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:survey_app/src/helper.dart';

// ignore: must_be_immutable
class RatingWidget extends StatefulWidget {
  double rate;
  String rateStatus;

  String khmerQestion;
  String engQestion;

  Function (double) callback;



  RatingWidget(
      {Key? key,
      required this.khmerQestion,
      required this.engQestion,
      required this.rate,
      required this.rateStatus,
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
                  widget.rateStatus,
                  style: TextStyle(
                      color: Helper.COLOR_PRIMARY,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Center(
                    child: RatingBar.builder(
                  initialRating: widget.rate,
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
                      widget.rate = rating.round().toDouble();
                      getOverallStatus(widget.rate);
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
        widget.rateStatus = 'Bad';
        break;
      case 2:
        widget.rateStatus = 'Normal';
        break;
      case 3:
        widget.rateStatus = 'Good';
        break;
      case 4:
        widget.rateStatus = 'Very Good';
        break;
      default:
        widget.rateStatus = 'Excellent';
        break;
    }
  }
}
