import 'dart:convert';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riders/components/count_down_timer.dart';
import 'package:riders/components/question_card.dart';
import 'package:riders/models/answered_questions.dart';
import 'package:riders/models/exam.dart';
import 'package:riders/models/question.dart';
import 'package:riders/screens/failedDialog.dart';
import 'package:riders/screens/select_lang.dart';

class MockPage extends StatefulWidget {
  final String language;
  MockPage({Key key, this.language}) : super(key: key);

  @override
  _MockPageState createState() => _MockPageState();
}

class _MockPageState extends State<MockPage>
    with SingleTickerProviderStateMixin {
  String questionString;
  List<Question> questions = List();
  bool isLoading = true;
  PageController _pageController = PageController();
  static int currentPage = 0;
  int selectedOption = 0;
  int remainingQuestions = 20;
  Question currentQuestion;
  FlareController flareController;
  bool isAnswerRight = false;
  bool isAnswerWrong = false;
  bool isSucceeded = false;
  bool isFailed = false;
  AnimationController controller;
  bool isStarted = false;
  String selectedLang;
  AnsweredQuestions answeredQuestions;
  bool isHappy=false;
  bool isSad=false;

  @override
  void initState() {
    currentQuestion = Question();
    rootBundle.loadString('assets/questions.json').then((string) {
      questionString = string;
      Iterable l = json.decode(questionString);
      l.forEach((f) {
        questions.add(Question.fromJson(f));
      });
      setState(() {
        isLoading = false;
      });
    });
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    CountDownTimer.onTimeOut = timedOut;
    Future.delayed(Duration(milliseconds: 100)).then((value){
      CountDownTimer().activate();
    });
    
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
    return WillPopScope(
      
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mock Test'),
        ),
        body: !isLoading
            ? Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white30,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Expanded(
                          child: FlareActor(
                            'assets/Teddy.flr',
                            animation: isHappy || isSucceeded
                                ? 'success'
                                : isSad || isFailed ? 'fail' : 'idle',
                            controller: flareController,
                            fit: BoxFit.fill,
                            callback: (value) {
                              if (!isFailed || !isSucceeded) {
                                setState(() {
                                  isHappy = false;
                                  isSad = false;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 12,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                  'Correct Answers : ${Exam().correctAnswers.toString()}'),
                              Container(
                                height: 70,
                                width: 70,
                                child: CountDownTimer(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                  'Remaining : ${(Exam().remainingQuestions).toString()}')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 90),
                    child: PageView.builder(
                      onPageChanged: (page) {
                        currentPage = page;
                        selectedOption = 0;
                        setState(() {
                          isAnswerRight=false;
                          isAnswerWrong=false;
                        });
                        
                      },
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 20,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        Exam().currentQuestion = index;
                        currentQuestion = questions[index];
                        return Container(
                          child: Column(
                            children: <Widget>[
                              isFailed
                                  ? showFailedDialog()
                                  : isSucceeded
                                      ? showPassDialog()
                                      : AnimatedBuilder(
                                          animation: offsetAnimation,
                                          builder: (buildContext, child) {
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      offsetAnimation.value + 8.0,
                                                  right: 8.0 -
                                                      offsetAnimation.value),
                                              child: QuestionCards(
                                                  isCorrect: isAnswerRight,
                                                  isWrong: isAnswerWrong,
                                                  question: currentQuestion,
                                                  questionNo: index + 1,
                                                  onOptionChoosed: (int choice) {
                                                    selectedOption = choice;
                                                  }),
                                            );
                                          }),
                              SizedBox(
                                height: 80,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: isFailed || isSucceeded
                          ? Container()
                          : Column(
                              children: <Widget>[
                                Container(
                                  child: RaisedButton(
                                    color: Colors.greenAccent,
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Text('Continue'),
                                    onPressed: () {
                                      setState(() {
                                        isSad=false;
                                        isHappy=false;
                                      });
                                      if (selectedOption != 0) {
                                        if (selectedOption ==
                                            currentQuestion.correctAnswer) {
                                          answeredQuestions = AnsweredQuestions(
                                              currentQuestion,
                                              selectedOption,
                                              true,
                                              false);
                                          setState(() {
                                            isHappy=true;
                                            isSad=false;
                                            isAnswerRight = false;
                                            isAnswerRight = true;
                                          });
                                          Exam().answeredCorrect(answeredQuestions);
                                        } else {
                                          answeredQuestions = AnsweredQuestions(
                                              currentQuestion,
                                              selectedOption,
                                              false,
                                              true);
                                          setState(() {
                                            isHappy=false;
                                            isSad=true;
                                            isAnswerRight = false;
                                            isAnswerWrong = true;
                                          });
                                          Exam().wrongAnswered(answeredQuestions);
                                        }
                                        if (Exam().remainingQuestions +
                                                Exam().correctAnswers <
                                            12) {
                                          setState(() {
                                            isFailed = true;
                                          });
                                        } else if (Exam().correctAnswers >= 12) {
                                          setState(() {
                                            isSucceeded = true;
                                          });
                                        }
                                        if (!isSucceeded || !isFailed) {
                                          _pageController.animateToPage(
                                              currentPage + 1,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.linearToEaseOut);
                                        }
                                      } else {
                                        controller.forward(from: 0.0);
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('Please select an option'),
                                          action: SnackBarAction(
                                            label: 'ok',
                                            onPressed: () {},
                                          ),
                                        ));
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      RaisedButton(
                                        color: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.exit_to_app,
                                              color: Colors.white70,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Back to Menu',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Exam().clearData();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      RaisedButton(
                                        color: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.receipt,
                                              color: Colors.white70,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'End & Review',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {},
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                ],
              )
            : Container(
                color: Colors.deepPurpleAccent,
                height: double.infinity,
                width: double.infinity,
                child: CupertinoActivityIndicator(
                  radius: 30,
                ),
              ),
      ), onWillPop: () {
        Exam().clearData();
        return Future(()=>true);
      },
    );
  }

  showFailedDialog() {
    return FailedDialog();
  }

  showPassDialog() {
    return Container(
      color: Colors.green.withOpacity(0.2),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.7,
    );
  }

  void timedOut() {
    setState(() {
      isFailed = true;
    });
  }

  void showSelectLangDialog() {
    showDialog(child: SelectLang(), context: context);
  }
}
