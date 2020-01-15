import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  final String currentLanguage;
  final ValueChanged<String> onSelected;
  const InfoPage({Key key, this.onSelected, this.currentLanguage})
      : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String selectedLang;

  @override
  void initState() {
    selectedLang = widget.currentLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 100,sigmaY: 100),
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/riders_wall2.png'),
                      fit: BoxFit.fill)),
            ),
            Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Riders Driving School has been successfully educating new drivers in Trivandrum since 2015. We strives to provide quality education and continued customer satisfaction.',
                  textWidthBasis: TextWidthBasis.parent,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )),
            // Divider(
            //   height: 0,
            // ),
            Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Reach Us',
                  style: TextStyle(
                    fontSize: 16.5,
                  ),
                )),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.5))),
                padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                margin: EdgeInsets.only(left: 8, right: 8),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Container(width: 65, child: Text('Address')),
                      Container(
                          padding: EdgeInsets.only(left: 8, right: 16),
                          child: VerticalDivider(
                            width: 0,
                          )),
                      Expanded(
                        child: Container(
                          child: Text(
                            'Canara bank building, Kunnathukal Jn\nThiruvananthapuram, Kerala - 695504',
                            
                          ),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                        child: Icon(FontAwesome.map_marker),
                        onTap: (){
                          _launchURL('https://goo.gl/maps/YspCtudhvyysruQq5');
                        },
                        ),
                        
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 4,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.5))),
                padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                margin: EdgeInsets.only(left: 8, right: 8),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Container(width: 65, child: Text('Phone 1')),
                      Container(
                          padding: EdgeInsets.only(left: 8, right: 16),
                          child: VerticalDivider(
                            width: 0,
                          )),
                      Expanded(
                        child: Container(
                          child: Text(
                            '+ 91 - 9497187486',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _launchURL('tel:+919497187486');
                        },
                        child: Container(
                          child: Icon(FontAwesome.phone)))
                    ],
                  ),
                )),
            SizedBox(
              height: 4,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.5))),
                padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                margin: EdgeInsets.only(left: 8, right: 8),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Container(width: 65, child: Text('Phone 2')),
                      Container(
                          padding: EdgeInsets.only(left: 8, right: 16),
                          child: VerticalDivider(
                            width: 0,
                          )),
                      Expanded(
                        child: Container(
                          child: Text(
                            '+91 - 9526319287',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _launchURL('tel:+919526319287');
                        },
                        child: Container(
                          child: Icon(FontAwesome.phone)))
                    ],
                  ),
                )),
            SizedBox(
              height: 4,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.5))),
                padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                margin: EdgeInsets.only(left: 8, right: 8),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Container(width: 65, child: Text('E-mail')),
                      Container(
                          padding: EdgeInsets.only(left: 8, right: 16),
                          child: VerticalDivider(
                            width: 0,
                          )),
                      Expanded(
                        child: Container(
                          child: Text(
                            'riders.mds@gmail.com',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _launchURL('mailto:riders.mds@gmail.com');
                        },
                        child: Container(
                          child: Icon(Feather.mail))),
                    ],
                  ),
                )),
            SizedBox(
              height: 4,
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesome5Brands.whatsapp),
                    onPressed: () {
                      _launchURL('https://wa.me/919526319287');
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesome5Brands.facebook),
                    onPressed: () {
                      _launchURL('https://www.facebook.com/riders.mds');
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesome5Brands.google),iconSize: 21,
                    onPressed: () {
                      _launchURL('https://www.google.com/search?rlz=1C1CHBF_enIN805IN805&sxsrf=ACYBGNTtOv_L0JJSFf4hSs-0-F2GPrTP2w%3A1578311572744&ei=lB8TXriOLd2Q4-EP2N-juAE&q=Riders+motor+driving+school+kunnathukal%2C+Trivandrum%2C+Kerala&oq=riders+motor+d&gs_l=psy-ab.1.3.0i22i30l3j38.311790.331767..335143...7.0..0.153.1557.8j7......0....1..gws-wiz.......35i39j0j0i20i263j0i10j0i22i10i30j0i273.knjUiBFk37A#lrd=0x3b05acee4bed057b:0x54c9aa75d7fe6392,3,,,');
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4),
                alignment: Alignment.bottomCenter,
                child: Text(
                  'App powered by siphlo ©',
                  style:TextStyle(fontSize: 12)
                ),
              ),
            ),
            SizedBox(height: 60,)
          ],
        ),
      ),
    );
  }
  void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}
