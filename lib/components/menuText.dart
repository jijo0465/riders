import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MenuText extends StatelessWidget {
  final String language;
  const MenuText({Key key, this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(children: <InlineSpan>[
          WidgetSpan(
              child: Icon(
            FontAwesome5Solid.graduation_cap,
            size: 19,
          )),
          TextSpan(
              text: language == 'ml'
                  ? '    RTO ലേണേഴ്സ് പരീക്ഷ'
                  : '    RTO Learners Exam',
              style: TextStyle(fontSize: 17, color: Colors.black)),
          WidgetSpan(
              child: Container(
                  padding: EdgeInsets.only(top: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: language=='en'? 4:6),
                          child: Icon(
                            FontAwesome5Solid.circle,
                            size: 8,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        flex: 9,
                        child: Container(
                          child: Text(language == 'ml'
                              ? 'ഈ പരീക്ഷയിൽ റോഡിന്റെ അടയാളങ്ങളും നിയമങ്ങളും നിയന്ത്രണങ്ങളും ഉൾപ്പെടുന്നു.'
                              : 'This exam includes traffic signs, rules and regulations of the road.'),
                        ),
                      )
                    ],
                  ))),
          WidgetSpan(
              child: Container(
            padding: EdgeInsets.only(top: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: language=='en'? 4:6),
                    child: Icon(
                      FontAwesome5Solid.circle,
                      size: 8,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Flexible(
                  flex: 9,
                  child: Container(
                    child: Text(language == 'ml'
                        ? 'പരീക്ഷയിൽ 20 ചോദ്യങ്ങളുണ്ട്, പരീക്ഷ വിജയിക്കാൻ 12 ചോദ്യങ്ങൾക്ക് ശരിയായി ഉത്തരം നൽകേണ്ടതുണ്ട്.'
                        : 'Exam has 20 questions, candidates are required to correctly answer 12 questions to pass the test.'),
                  ),
                )
              ],
            ),
          )),
          WidgetSpan(
              child: Container(
            padding: EdgeInsets.only(top: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: language=='en'? 4:6),
                    child: Icon(
                      FontAwesome5Solid.circle,
                      size: 8,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Flexible(
                  flex: 9,
                  child: Container(
                    child: Text(language =='ml'?
                        'പരീക്ഷയ്ക്ക് 20 മിനിറ്റ് സമയം അനുവദിച്ചിരിക്കുന്നു.':
                        'Candidates are allotted 20 minutes for the exam.'),
                  ),
                )
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
