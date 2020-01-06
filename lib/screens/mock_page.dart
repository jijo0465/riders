import 'dart:convert';
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
import 'package:riders/screens/review_answers.dart';
import 'package:riders/screens/select_lang.dart';
import 'package:riders/screens/successDialog.dart';

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
  int currentPage;
  int selectedOption = 0;
  int remainingQuestions = 20;
  Question currentQuestion;
  FlareController flareController;
  bool isAnswerRight = false;
  bool isAnswerWrong = false;
  bool isSucceeded = false;
  bool isFailed = false;
  AnimationController controller;
  bool isAnimating = false;
  String selectedLang;
  AnsweredQuestions answeredQuestions;

  @override
  void initState() {
    currentPage = 0;
    currentQuestion = Question();
    if (widget.language == 'en') {
      rootBundle.loadString('assets/json/questions_en.json').then((string) {
        questionString = string;
        Iterable l = json.decode(questionString);
        l.forEach((f) {
          questions.add(Question.fromJson(f));
        });
        setState(() {
          isLoading = false;
        });
      });
    } else if (widget.language == 'ml') {
      rootBundle.loadString('assets/json/exam_ml.json').then((string) {
        questionString = string;
        Iterable l = json.decode(questionString);
        l.forEach((f) {
          questions.add(Question.fromJson(f));
        });
        setState(() {
          isLoading = false;
        });
      });
    }
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    CountDownTimer.onTimeOut = timedOut;
    // Future.delayed(Duration(milliseconds: 200)).then((value){
    // CountDownTimer().activate();
    // });

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
          title: Text(widget.language=='ml'?'ലേണേഴ്സ് പരീക്ഷ':'Learners Exam'),
        ),
        body: !isLoading
            ? Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/background/rules.png',))
                    ),
                  ),
                  Column(children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 12,),
                            Text(
                                'Correct Answers :  ${Exam().correctAnswers.toString()}',style: TextStyle(fontSize: 13),),
                            Expanded(
                              child: Container(
                                height: 70,
                                width: 70,
                                child: CountDownTimer(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                                'Remaining :  ${(Exam().remainingQuestions).toString()}',style: TextStyle(fontSize: 13 )),
                                SizedBox(width: 12,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      flex: 7,
                      child: Container(
                        child: PageView.builder(
                          onPageChanged: (page) {
                            currentPage = page;
                            selectedOption = 0;
                            Future.delayed(Duration(milliseconds: 200))
                                .then((onValue) {
                              setState(() {
                                isAnswerRight = false;
                                isAnswerWrong = false;
                                isAnimating = false;
                              });
                            });
                          },
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 20,
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            Exam().currentQuestion = index;
                            currentQuestion = questions[index];
                            return AnimatedBuilder(
                                animation: offsetAnimation,
                                builder: (buildContext, child) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        left: offsetAnimation.value + 4.0,
                                        right: 4.0 - offsetAnimation.value),
                                    child: QuestionCards(
                                        isCorrect: isAnswerRight,
                                        isWrong: isAnswerWrong,
                                        question: currentQuestion,
                                        questionNo: index + 1,
                                        onOptionChoosed: (int choice) {
                                          selectedOption = choice;
                                        }),
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Flexible(
                        flex: 1,
                        child: Container(
                          child: RaisedButton(
                            color: Colors.greenAccent,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Text('Continue'),
                            onPressed: () {
                              if (!isAnimating) {
                                isAnimating = true;
                                if (selectedOption != 0) {
                                  if (selectedOption ==
                                      currentQuestion.correctAnswer) {
                                    answeredQuestions = AnsweredQuestions(
                                        currentQuestion,
                                        selectedOption,
                                        true,
                                        false);
                                    setState(() {
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
                                    Future.delayed(Duration(milliseconds: 700))
                                        .then((onValue) {
                                      _pageController.animateToPage(
                                          currentPage + 1,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linearToEaseOut);
                                    });
                                  }
                                } else {
                                  controller.forward(from: 0.0);
                                  isAnimating = false;
                                }
                              }
                            },
                          ),
                        )),
                    SizedBox(
                      height: 18,
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
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
                                    style: TextStyle(color: Colors.white70),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
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
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                reviewAnsweres();
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                  isSucceeded
                      ? Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 80),
                          child: SuccessDialog(
                            tryAgainTapped: () {
                              tryAgain();
                            },
                            reviewTapped: () {
                              reviewAnsweres();
                            },
                          ))
                      : isFailed
                          ? Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 80),
                              child: FailedDialog(
                                tryAgainTapped: () {
                                  tryAgain();
                                },
                                reviewTapped: () {
                                  reviewAnsweres();
                                },
                              ))
                          : Container()
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
      ),
      onWillPop: () {
        Exam().clearData();
        return Future(() => true);
      },
    );
  }

  void reviewAnsweres() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ReviewAnswers()));
  }

  void tryAgain() {
    Exam().clearData();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MockPage(
                  language: widget.language,
                )));
  }

  void timedOut() {
    setState(() {
      isFailed = true;
    });
  }
}
