import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:riders/components/instruction.dart';

class Instructions extends StatefulWidget {
  final String language;
  const Instructions({Key key,@required this.language}) : super(key: key);

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions>
    with AutomaticKeepAliveClientMixin<Instructions> {
  PageController _pageController = PageController();
  // PageController tabController = PageController();
  int _selectedAnimation = 1;
  Timer timer;
  @override
  void initState() {
    // Timer.periodic(Duration(seconds: 6, milliseconds: 38), (timer) {
    //   controls.play('eight');
    //   hControls.play('h');
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      pageSnapping: true,
      children: <Widget>[
        Stack(
          children: <Widget>[
            // PageView(
            //   controller: tabController,
            //   physics: NeverScrollableScrollPhysics(),
            //   children: <Widget>[
            // Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //     child: FlareActor(
            //       'assets/eight.flr',
            //       fit: BoxFit.fitHeight,
            //       animation: 'eight',
            //     )),
            // Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //     child: FlareActor(
            //       'assets/h.flr',
            //       fit: BoxFit.cover,
            //       animation: 'h',
            //     ))
            //   ],
            // ),
            AnimatedCrossFade(
              sizeCurve: Curves.fastLinearToSlowEaseIn,
              crossFadeState: _selectedAnimation == 1?CrossFadeState.showFirst:CrossFadeState.showSecond,
              duration: Duration(milliseconds: 800),
              firstChild: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FlareActor(
                    'assets/eight.flr',
                    fit: BoxFit.fitHeight,
                    animation: 'eight',
                  )),
              secondChild: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FlareActor(
                    'assets/h.flr',
                    fit: BoxFit.cover,
                    animation: 'h',
                  )),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: CupertinoSegmentedControl(
                groupValue: _selectedAnimation,
                padding: EdgeInsets.all(8),
                selectedColor: Colors.deepPurple[500],
                unselectedColor: Colors.deepPurple[100],
                pressedColor: Colors.deepPurple[300],
                children: {
                  1: Text('  Two Wheeler  '), 
                  2: Text('  LMV  ')},
                onValueChanged: (value) {
                  setState(() {
                    _selectedAnimation = value;
                  });
                  // tabController.animateToPage(
                  //   _selectedAnimation - 1,
                  //   curve: Curves.fastLinearToSlowEaseIn,
                  //   duration: Duration(milliseconds: 800),
                  // );
                },
              ),
            ),
            Positioned(
              top: 36,
              right: 0,
              child: GestureDetector(
                onTap: (){
                  _pageController.animateToPage(2,curve: Curves.easeInCubic,duration: Duration(milliseconds: 400));
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[700],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesome.info_circle,
                        size: 26,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Feather.arrow_right,
                        size: 28,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          child: Instrunction(language:widget.language,category: _selectedAnimation,),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
