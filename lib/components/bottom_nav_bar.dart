import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final ValueChanged<int> onChanged;
  const BottomNavBar({Key key, this.onChanged}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selected=1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      color: Colors.white30,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8,sigmaY: 8),
          child: Container(
            padding: EdgeInsets.all(6),
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  height: 50,
                  child: GestureDetector(
                    onTap: (){
                      widget.onChanged(1);
                      setState(() {
                        selected=1;
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.child_care,
                        color: selected==1?Colors.deepPurple:Colors.black,
                        ),
                        Text('Practice',
                          style: TextStyle(
                            color: selected==1?Colors.deepPurple:Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: GestureDetector(
                    onTap: (){
                      widget.onChanged(2);
                      setState(() {
                        selected=2;
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.warning,color: selected==2?Colors.deepPurple:Colors.black,),
                        Text('Signals',
                          style: TextStyle(
                            color: selected==2?Colors.deepPurple:Colors.black,
                          ),)
                      ],
                    ),
                  ),
                ),
                
                Container(
                  height: 50,
                  child: GestureDetector(
                    onTap: (){
                      widget.onChanged(3);
                      setState(() {
                        selected=3;
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.image,color: selected==3?Colors.deepPurple:Colors.black,),
                        Text('How to',
                          style: TextStyle(
                            color: selected==3?Colors.deepPurple:Colors.black,
                          ),)
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: GestureDetector(
                    onTap: (){
                      widget.onChanged(4);
                      setState(() {
                        selected=4;
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.question_answer,color: selected==4?Colors.deepPurple:Colors.black,),
                        Text('Qestionaire',
                          style: TextStyle(
                            color: selected==4?Colors.deepPurple:Colors.black,
                          ),)
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}