import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riders/components/bottom_nav_bar.dart';
import 'package:riders/screens/info_page.dart';
import 'package:riders/screens/instructions.dart';
import 'package:riders/screens/learners_menu.dart';
import 'package:riders/screens/rules_act.dart';
import 'package:riders/screens/select_lang.dart';
import 'package:riders/screens/signals_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int navSelected = 1;
  PageController pageController = PageController();
  bool selectLang = false;
  String language = 'en';
  bool infoOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Riders Motor Driving School'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                setState(() {
                  selectLang = true;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                setState(() {
                  infoOpen = true;
                  selectLang = true;
                });
              },
            )
          ],
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/background/rules.png')))),
              Container(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: <Widget>[
                    Instructions(language: language,),
                    SignalsPage(
                      language: language,
                    ),
                    LearnersMenu(language: language),
                    RulesAct(language: language)
                  ],
                ),
              ),
              // Container(
              //   height: 70,
              //   child: AppBar(
              //     backgroundColor: Colors.deepPurple,
              //     title: Text('Riders Driving School'),
              //     actions: <Widget>[
              //       IconButton(
              //         icon: Icon(Icons.language),
              //         onPressed: () {
              //           setState(() {
              //             selectLang = true;
              //           });
              //         },
              //       ),
              //       IconButton(
              //         icon: Icon(Icons.info),
              //         onPressed: () {},
              //       )
              //     ],
              //   ),
              // ),
              Container(
                alignment: Alignment.bottomCenter,
                child: BottomNavBar(
                  onChanged: (value) {
                    setState(() {
                      navSelected = value;
                    });
                    pageController.animateToPage(value - 1,
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(milliseconds: 300));
                  },
                ),
              ),
              selectLang
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          selectLang = false;
                          infoOpen = false;
                        });
                      },
                      child: Container(
                          color: Colors.black.withOpacity(0.3),
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {},
                            child: infoOpen?InfoPage(): SelectLang(
                              currentLanguage: language,
                              onSelected: (value) {
                                setState(() {
                                  language = value;
                                  selectLang = false;
                                });
                              },
                            ),
                          )),
                    )
                  : Container()
            ],
          ),
        ));
  }
}
