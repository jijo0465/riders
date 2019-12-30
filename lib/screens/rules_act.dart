import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riders/components/pdf_link.dart';
import 'package:riders/screens/rules_pdf.dart';


class RulesAct extends StatelessWidget {
  final String language;
  const RulesAct({Key key,this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[100],
      padding: EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 90,),
          PdfLink(
            text: "Pdf Link hsauodhf fadsufhu fsdiaifisd fsdhfifsd fsdhifhi fsdihfsd fsidfhi fsdidhisd fihids",
            onTap: (){
              getFileFromAsset('resume.pdf').then((file){
                String path=file.path;
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RulesPdf(path:path)
                ));
              });
            },
          ),
          SizedBox(
            height: 12,
          ),
          PdfLink(
            text: "Pdf Link",
            onTap: (){
              print('Ontap is called');
            },
          ),
          SizedBox(
            height: 12,
          ),
          PdfLink(
            text: "Pdf Link",
            onTap: (){
              print('Ontap is called');
            },
          ),
          SizedBox(
            height: 12,
          ),
          PdfLink(
            text: "Pdf Link",
            onTap: (){
              print('Ontap is called');
            },
          ),
          SizedBox(
            height: 12,
          ),
          PdfLink(
            text: "Pdf Link",
            onTap: (){
              print('Ontap is called');
            },
          ),
          SizedBox(
            height: 12,
          ),
          PdfLink(
            text: "Pdf Link",
            onTap: (){
              print('Ontap is called');
            },
          ),
          SizedBox(
            height: 12,
          ),
          PdfLink(
            text: "Pdf Link",
            onTap: (){
              print('Ontap is called');
            },
          ),
          SizedBox(
            height: 12,
          ),
          PdfLink(
            text: "Pdf Link",
            onTap: (){
              print('Ontap is called');
            },
          ),
          SizedBox(
            height: 12,
          ),
          PdfLink(
            text: "Pdf Link",
            onTap: (){
              print('Ontap is called');
            },
          ),
          SizedBox(
            height: 12,
          ),
          PdfLink(
            text: "Pdf Link",
            onTap: (){
              print('Ontap is called');
            },
          ),
        ],
      ),
    );
  }

  Future<File> getFileFromAsset(String asset)async{
    try{
      var data = await rootBundle.load('assets/pdf/$asset');
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/$asset.pdf');
      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    }catch(e){
      print('ERROR');
    }
  }
}