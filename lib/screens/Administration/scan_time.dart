// ignore: import_of_legacy_library_into_null_safe
// import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';


class Scan extends StatefulWidget {
  const Scan({Key key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}
var time= DateTime.now();

class _ScanState extends State<Scan> {
  String qrCodeResult= "Unknown";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:const Text("Scanner",
              style: TextStyle(
              color: Colors.white,
              ),),
        centerTitle: true,
      ),
      body: Container(
        padding:const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
             " date of $qrCodeResult is $time ",
              style:const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25,),
              textAlign: TextAlign.center,
            ),
            
            
          const SizedBox(height: 20.0, ),
              
           
            // ignore: deprecated_member_use
            FlatButton(
              padding:const EdgeInsets.all(15.0),
              onPressed: () async {


                // String codeSanner = (await BarcodeScanner.scan()) as String;
                // setState(() {
                //   qrCodeResult = codeSanner;
                // });
              },
              child:const  Text(
                "Open Scanner",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side:const BorderSide(color: Colors.blue, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
            )
          ],
        ),
      ),
    );
  }
}
