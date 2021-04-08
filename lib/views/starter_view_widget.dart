import 'package:flutter/material.dart';
import 'package:survey_app/widgets/helper.dart';

class StarterViewWidget extends StatefulWidget {
  final Function(String) onSelected;

  StarterViewWidget({Key? key, required this.onSelected});

  @override
  State<StatefulWidget> createState() {
    return _StarterViewWidget();
  }
}

class _StarterViewWidget extends State<StarterViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        Positioned(
            top: 50,
            left: 10,
            child: Image.asset("assets/images/title.jpg",
                width: 200,
                color: Color.fromRGBO(255, 255, 255, 0.3),
                colorBlendMode: BlendMode.modulate)),
        Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset("assets/images/bush.jpg", width: 150)),
        Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/bush_rev.jpg", width: 150)),
        bodyWidget(),
      ],
    );
  }

  Widget bodyWidget() {
    return Container(
      margin: EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: [
                      Text('សួស្តីបង! សូមជួយផ្តល់ មតិយោបល់ ដល់ផ្សារការ៉ុតផង',
                          style: Helper.headerKhmer, textAlign: TextAlign.left),
                      Text(
                          'សម្រាប់ក្នុងការកែសម្រួលគុណភាពនៃ ផលិតផល នឹង សេវាកម្ម',
                          style: Helper.subtitleKhmer,
                          textAlign: TextAlign.left)
                    ],
                  ))),
          Helper.questionLabelInKhmerEng(
              'ពេញចិត្តសេវាកម្មនៅផ្សារការ៉ុតនៅថ្ងៃេនះទេ បង?',
              'How is our service today?'),
          emotionalReaction()
        ],
      ),
    );
  }

  Widget reactionWidget(String imagePath, String caption, String captionEn) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTapUp: (detail) => widget.onSelected(captionEn),
          child: Image.asset(
            imagePath,
            width: 50.0,
            height: 50.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            caption,
            style: Helper.subtitleKhmer,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            captionEn,
            style: Helper.subtitleEng,
          ),
        )
      ],
    );
  }

  Widget emotionalReaction() {
    return Expanded(
      child: Center(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 150.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              reactionWidget('assets/images/angry.gif', 'មិនរីករាយ', 'Unhappy'),
              reactionWidget('assets/images/mmm.gif', 'ធម្មតា', 'Neutral'),
              reactionWidget(
                  'assets/images/hearteyes.gif', 'រីករាយ', 'Satisfied')
            ],
          ),
        ),
      ),
    );
  }
}
