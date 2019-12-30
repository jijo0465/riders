import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PdfLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const PdfLink({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.blueAccent[700],
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(width: 12,),
            Container(
              child: Icon(
                Feather.external_link,
                color: Colors.blueAccent[700],
                size: 19,
              ),
            ),
            SizedBox(
              width: 12,
            )
          ],
        ),
      ),
    );
  }
}
