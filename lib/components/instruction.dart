import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Instrunction extends StatelessWidget {
  final String language;
  final int category;
  const Instrunction({Key key, this.language, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            instructionTitle(
              category == 1
                  ? language == 'ml'
                      ? '8 ടെസ്റ്റ് ട്രാക്കിലെ നിബന്ധനകൾ'
                      : 'Terms - 8 Test Track'
                  : language == 'ml'
                      ? 'H ട്രാക്കിലെ നിബന്ധനകൾ'
                      : 'Terms - H Test Track',
            ),
            instructionCard(category == 1
                ? language == 'ml'
                    ? 'മോട്ടോർ സൈക്കിൾ എടുക്കുന്ന ആൾ വാഹനം സ്റ്റാർട്ട് ചെയ്ത്, ഹെൽമറ്റ് ധരിച്ച് ചിൻസ്ട്രാപ്പ് ഇട്ടതിനുശേഷം, കൺട്രോൾ റൂമിൽനിന്നുള്ള നിർദ്ദേശം കിട്ടിയാലുടൻ തന്നെ ടെസ്റ്റ് ആരംഭിക്കേണ്ടതാണ്.'
                    : 'The motorcyclist starts the vehicle, wears the helmet and puts on the chinstrap. The test should be started immediately after receiving instruction from the control room.'
                : language == 'ml'
                    ? 'സ്റ്റാർട്ടിങ്ങ് പോയിന്റിൽ നിന്നും നിർദ്ദേശം ലഭിക്കുന്നതനുസരിച്ച്\n1. H ആകൃതിയിൽ ഉള്ളട്രാക്കിൽ, A യിൽ നിന്നും B യിലേക്ക് മുന്നോട്ടും \n2. B യിൽ നിന്ന് C യിലേയ്ക്ക് പിന്നോട്ടും \n3. C യിൽനിന്നും D യിലേയ്ക്ക് മുന്നോട്ടും \n4. D യിൽനിന്ന് A യിലേയ്ക്ക് പിന്നോട്ടും വാഹനം ഓടിക്കുക.'
                    : 'Once gotten instruction:\n1. Start moving forward from A to B,\n2. Backwards towards B to C,\n3. Forwards from C to D and backward towards D to A on the track having “H” Shape.\n4. The wheels of the vehicle must not stop while moving from a point to another.'),
            instructionCard(category == 1
                ? language == 'ml'
                    ? 'ട്രാക്കിലേയ്ക്ക് ഇടവിട്ടിട്ടുള്ള വെള്ള വര വഴി വലത്തോട്ട് പ്രവേശിച്ച് 8 ആകൃതിയിൽ വാഹനം ഓടിച്ച് ടെസ്റ്റ് മുഴുവിപ്പിക്കേണ്ടതാണ്.'
                    : 'Form an 8-Shape using the vehicle after entering the right side of the line via intermittent white lines.'
                : language == 'ml'
                    ? 'ഒരു പോയിന്റിൽ നിന്നും മറ്റൊരു പോയിന്റിലേയ്ക്ക് പോകുമ്പോൾ വാഹനത്തിന്റെ വീലുകൾ നിശ്ചലമാകാൻ പാടുള്ളതല്ല. '
                    : 'The wheels of the vehicle must not stop while moving from a point to another.'),
            SizedBox(
              height: 8,
            ),
            instructionTitle(language == 'ml'
                ? 'പരാജയപ്പെടാവുന്ന സാഹചര്യങ്ങൾ'
                : 'Failing situations'),
            instructionCard(category == 1
                ? language == 'ml'
                    ? 'മോട്ടോർ സൈക്കിളിലെ ടെസ്റ്റിൽ ട്രാക്കിനുള്ളിൽ കാലുകുത്തുന്നതും വാഹനം നിന്ന് പോകുന്നതും, വാഹനത്തിന്റെയോ വസ്ത്രത്തിന്റെയോ, ശരീരത്തിന്റെയോ ഭാഗങ്ങൾ ട്രാക്കിന്റെ വെള്ളവര മറികടക്കുന്നത്.'
                    : 'Placing feet on the ground, vehicles getting stuck in the track or the parts of vehicle, clothing and body crossing the white line in the event of test of a motorcycle.'
                : language == 'ml' ? 'ഒരു വാഹനം H ട്രാക്കിന്റെ നാല് അറ്റങ്ങളിലും എത്താത്ത സാഹചര്യത്തിൽ.' : 'In the event that the  vehicle does not reach all the 4 corners of the “H”.'),
            instructionCard(
              category == 1?
              language == 'ml'
                ? 'ഓട്ടോറിക്ഷ ട്രാക്കിൽ നിന്നുപോകുന്നത്, വെള്ള വര മറികടക്കുന്നത്.'
                : 'Autorikshaw exiting the track or crossing the white line.'
                : language == 'ml' ? 'ഒരു പോയിന്റിൽ നിന്നും മറ്റൊരു പോയിന്റിലേയ്ക്കുള്ള വാഹന യാത്രയ്ക്കിടയിൽ വീലുകൾ നിശ്ചലമായാൽ.' 
                : 'The wheel stops during the journey of the vehicle from one point to other.'),
            category == 2?instructionCard(
              language == 'ml'?'A,B,C,D എന്നീ പോയിന്റുകൾ ഒഴിച്ച് ട്രാക്കിലെ വെള്ള വര വീലുകളൊ വാഹനത്തിന്റെ ഭാഗങ്ങളൊ മറി കടന്നാൽ.'
              :'If either the wheels or any body parts of the vehicle crosses the white line except for the point A, B, C & D.'
            ):Container(),
            category == 2?instructionCard(
              language == 'ml'?'A,B,C,D എന്നീ പോയിന്റുകൾ ഒഴിച്ച് ട്രാക്കിൽ വാഹനത്തിന്റെ ദിശ മാറ്റിയാൽ.'
              :'Change in direction of the vehicle except for the point A, B, C & D.'
            ):Container(),
            // Container(
            //     // padding: EdgeInsets.only(bottom: 57),
            //     // alignment: Alignment.bottomCenter,
            //     child: Text(
            //       'Swipe right to go back to animation',
            //       style: TextStyle(color: Colors.black54, fontSize: 12),
            //     ))
            SizedBox(
              height: 56,
            )
          ],
        ),
      ),
    );
  }

  Widget instructionCard(String text) {
    return Container(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.circular(12))),
            elevation: 0,
            color: Colors.white.withOpacity(0.25),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                text,
                style:
                    TextStyle(fontSize: 16, letterSpacing: 0.3, wordSpacing: 2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget instructionTitle(String text) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(text,
          style: TextStyle(
            fontSize: 18, letterSpacing: 0.3, wordSpacing: 2,fontWeight: FontWeight.w600)),
    );
  }
}
