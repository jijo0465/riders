import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riders/models/question.dart';

class Questionaire extends StatefulWidget {

  @override
  _QuestionaireState createState() => _QuestionaireState();
}

class _QuestionaireState extends State<Questionaire> {
  List<Question> questions=List();
  String questionString;
  bool isLoading=true;
  @override
  void initState() { 
    super.initState();
    rootBundle.loadString('assets/json/questions_en.json').then((string) {
      questionString = string;
      Iterable l = json.decode(questionString);
      l.forEach((f) {
        questions.add(Question.fromJson(f));
      });
      setState(() {
        isLoading=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading?Scaffold(
      appBar: AppBar(
          title: Text('Questionaire'),
        ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context,index){
            int correctAnswer=questions[index].correctAnswer;
            return ListTile(
              title: Text('Q ${index+1} : '+questions[index].question),
              subtitle: Text('Ans : ${correctAnswer==1?questions[index].option1:correctAnswer==2?questions[index].option2:questions[index].option3}'),
            );
          },
        ),
      ),
    ):Container();
  }
}