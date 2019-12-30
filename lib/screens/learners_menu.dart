import 'package:flutter/material.dart';
import 'package:riders/screens/mock_page.dart';
import 'package:riders/screens/practice_page.dart';
import 'package:riders/screens/questionaire.dart';

class LearnersMenu extends StatelessWidget {
  final String language;
  const LearnersMenu({
    Key key, this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 120,
          ),
          Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PracticePage(language: language,)));
                    },
                    child: Card(
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 12,
                      child: Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        child: Text('Practice all questions'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Questionaire()));
                  },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 12,
                      color: Colors.blueAccent,
                      child: Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        child: Text('Questionaire'),
                        
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            flex: 7,
            child: GestureDetector(
              onTap: () {
                // this.onTap(3);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MockPage()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 12,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Mock Exam'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
