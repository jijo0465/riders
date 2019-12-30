import 'package:flutter/material.dart';
import 'package:riders/models/exam.dart';

class ReviewAnswers extends StatelessWidget {
  const ReviewAnswers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(title: Text('Review'),),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: Exam().totalAnswered,
            itemBuilder: (buildContext,index){
              return ListTile(
                title: Text(Exam().answeredQuestions.elementAt(index).question.question),
              );
            },
          ),
        ),
      ), onWillPop: () {
        Exam().clearData();
        return Future.value(true);
      },
    );
  }
}