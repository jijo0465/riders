import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:riders/models/exam.dart';
import 'package:riders/models/question.dart';

class QuestionCards extends StatefulWidget {
  final Question question;
  final int questionNo;
  final ValueChanged<int> onOptionChoosed;
  final bool isCorrect;
  final bool isWrong;
  const QuestionCards(
      {Key key,
      this.question,
      this.questionNo,
      this.onOptionChoosed,
      this.isCorrect,
      this.isWrong})
      : super(key: key);

  @override
  _QuestionCardsState createState() => _QuestionCardsState();
}

class _QuestionCardsState extends State<QuestionCards>
    with AutomaticKeepAliveClientMixin<QuestionCards> {
  bool isAnswerRight = false;
  bool isAnswerWrong = false;
  int selectedValue = -1;
  bool hasImage = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    if(widget.question.asset!=''){
      setState(() {
        hasImage = true;
      });
    }
    print(hasImage);
    print(widget.question.asset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.question.asset);
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Card(
            color: Colors.deepPurple[200].withOpacity(0.5),
            elevation: 6,
            child: Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 4),
                    child: Text(
                      'Q${widget.questionNo} : ' + widget.question.question,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          wordSpacing: 2),
                    ),
                  ),
                  hasImage?Container(
                    child: Image.asset(
                    'assets/${widget.question.asset}',
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,
                  )
                  ):Container(),

                  Container(
                      child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        color: index == selectedValue
                            ?  widget.isCorrect
                                ? Colors.greenAccent.withOpacity(0.4)
                                : widget.isWrong
                                    ? Colors.redAccent.withOpacity(0.4)
                                    : Colors.amber.withOpacity(0.4)
                            : Colors.transparent,
                        child: RadioListTile(
                          activeColor: Colors.deepPurple,
                          title: Text(index == 0
                              ? widget.question.option1
                              : index == 1
                                  ? widget.question.option2
                                  : widget.question.option3),
                          onChanged: (int value) {
                            setState(() {
                              selectedValue = value;
                            });
                            widget.onOptionChoosed(value + 1);
                          },
                          groupValue: selectedValue,
                          value: index,
                        ),
                      );
                    },
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
