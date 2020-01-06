import 'dart:ui';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  final String currentLanguage;
  final ValueChanged<String> onSelected;
  const InfoPage({Key key, this.onSelected, this.currentLanguage}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String selectedLang;

  @override
  void initState() {
    selectedLang=widget.currentLanguage;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 80,sigmaY: 80),
      child: Container(
        
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 16,right: 16),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
              child: Image.asset('assets/riders.jpg'),
            ),
            Container(
              padding: EdgeInsets.only(top: 8,bottom: 8),
                child: 
                Text('Riders Motor Driving School',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),)),
                Divider(
                  height: 0,
                ),
          ],
        ),
      ),
    );
  }
}
