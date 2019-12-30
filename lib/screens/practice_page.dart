import 'dart:convert';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:riders/components/practice_question.dart';
import 'package:riders/models/answered_questions.dart';
import 'package:riders/models/exam.dart';
import 'package:riders/models/question.dart';
import 'package:riders/screens/review_answers.dart';
import 'package:riders/screens/select_lang.dart';

class PracticePage extends StatefulWidget {
  final String language;
  PracticePage({Key key, this.language}) : super(key: key);

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  String questionString;
  List<Question> questions = List();
  bool isLoading = true;
  PageController _pageController;
  int currentPage = 0;
  int selectedOption = 0;
  Question currentQuestion;
  FlareController flareController;
  bool isAnswerRight = false;
  bool isAnswerWrong = false;
  String selectedLang;
  AnsweredQuestions answeredQuestions;
  bool isHappy = false;
  bool isSad = false;
  int _index = 0;
  bool shouldScroll;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: _index, viewportFraction: 0.9);
    currentQuestion = Question();
    if (widget.language == 'ml') {
      rootBundle.loadString('assets/json/exam_ml.json').then((string) {
        questionString = string;
        Iterable l = json.decode(questionString);
        l.forEach((f) {
          questions.add(Question.fromJson(f));
        });
        setState(() {
          isLoading = false;
          currentQuestion = questions[0];
        });
      });
    }else if (widget.language == 'en') {
      rootBundle.loadString('assets/json/questions_en.json').then((string) {
        questionString = string;
        Iterable l = json.decode(questionString);
        l.forEach((f) {
          questions.add(Question.fromJson(f));
        });
        setState(() {
          isLoading = false;
          currentQuestion = questions[0];
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Exam().clearData();
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Practice Test'),
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
                            animation:
                                isHappy ? 'success' : isSad ? 'fail' : 'idle',
                            controller: flareController,
                            callback: (value) {
                              setState(() {
                                isHappy = false;
                                isSad = false;
                              });
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
                                child: Card(
                                  elevation: 8,
                                  color: Colors.amber.withOpacity(0.2),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100000))),
                                  child: Text(
                                      '${currentPage + 1}/${questions.length}'),
                                ),
                              ),
                              Text(
                                  'Wrong Answers : ${(Exam().totalAnswered - Exam().correctAnswers).toString()}')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 90),
                    child: NotificationListener(
                      child: PageView.builder(
                        allowImplicitScrolling: true,
                        physics: BouncingScrollPhysics(),
                        pageSnapping: false,
                        onPageChanged: (page) {
                          setState(() {
                            currentPage = page;
                          });
                          selectedOption = 0;
                          isAnswerRight = false;
                          isAnswerWrong = false;
                        },
                        itemCount: questions.length,
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          int answeredOption = 0;
                          currentQuestion = questions[index];
                          for (var q in Exam().answeredQuestions) {
                            if (q.question == currentQuestion) {
                              answeredOption = q.option;
                            }
                          }
                          return Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: PracticeQuestion(
                                      question: currentQuestion,
                                      answeredValue: answeredOption,
                                      correctValue:
                                          currentQuestion.correctAnswer,
                                      questionNo: index + 1,
                                      onOptionChoosed: (int choice) {
                                        print(selectedOption);
                                        selectedOption = choice;
                                        answeredCallback();
                                      }),
                                ),
                                SizedBox(
                                  height: 80,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      onNotification: (notification) {
                        try {
                          if (notification is ScrollStartNotification) {
                            shouldScroll = true;
                          }
                          if (notification is ScrollEndNotification &&
                              shouldScroll) {
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              _pageController.animateToPage(
                                  _pageController.page.ceil(),
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.fastLinearToSlowEaseIn);
                              shouldScroll = false;
                            });
                          }
                        } catch (e) {}

                        return true;
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 18,
                          ),
                          Container(
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
                                        Feather.log_out,
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
                                        Feather.book_open,
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
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReviewAnswers()));
                                  },
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
      ),
    );
  }

  void answeredCallback() {
    Question answeredQuestion;
    if (selectedOption != 0) {
      answeredQuestion = questions[_pageController.page.toInt()];
      if (selectedOption == answeredQuestion.correctAnswer) {
        answeredQuestions =
            AnsweredQuestions(answeredQuestion, selectedOption, true, false);
        setState(() {
          isHappy = true;
          isSad = false;
          isAnswerWrong = false;
          isAnswerRight = true;
        });
        Exam().answeredCorrect(answeredQuestions);
      } else {
        answeredQuestions =
            AnsweredQuestions(answeredQuestion, selectedOption, false, true);
        setState(() {
          isHappy = false;
          isSad = true;
          isAnswerRight = false;
          isAnswerWrong = true;
        });
        Exam().wrongAnswered(answeredQuestions);
      }
    }
    Future.delayed(const Duration(milliseconds: 900), () {
      // _pageController.animateToPage(currentPage + 1,
      //     duration: Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
      animateToPage(currentPage + 1);
    });
  }

  void showSelectLangDialog() {
    showDialog(child: SelectLang(), context: context);
  }

  void animateToPage(int pageNumber) {
    _pageController.animateToPage(currentPage + 1,
        duration: Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
  }
}
