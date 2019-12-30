import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class FailedDialog extends StatelessWidget {
  const FailedDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8,sigmaY: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.redAccent,
        ),
        margin: EdgeInsets.all(8),
        
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30, left: 12, right: 12),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  FlareActor('assets/Teddy.flr', animation: 'fail'),
                  Container(
                    height: 30,
                    alignment: Alignment.topCenter,
                    child: Text('Awww... You Failed!')),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: RaisedButton(
                              color: Colors.deepPurple[400].withOpacity(0.9 ),
                              elevation: 6,
                              child: Text('Try Again'),
                              onPressed: (){},
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: RaisedButton(
                              color: Colors.deepPurple[400],
                              onPressed: (){},
                              elevation: 6,
                              child: Text('Review'),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
