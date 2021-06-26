import 'package:a/screen/MoneyManagement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';  //for date format


import 'Main.dart';

class Scan extends StatefulWidget {
  SavingState createState() => new SavingState();

}

var _isLoading = false;
bool isExist = true;
bool isSameUser = false;
String? userEmail = FirebaseAuth.instance.currentUser!.email;
String use = FirebaseAuth.instance.currentUser!.uid;
var userName = FirebaseFirestore.instance
    .collection("Users")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .id;

CollectionReference users = FirebaseFirestore.instance.collection('Users');
final firestore = FirebaseFirestore.instance; //
FirebaseAuth auth = FirebaseAuth.instance;
Future<String> getUserName() async {
  final CollectionReference users = firestore.collection('Users');

  final String uid = auth.currentUser!.uid;

  final result = await users.doc(uid).get();
  return result.get('Name');
}

Future<String> getCivilID() async {
  final CollectionReference users = firestore.collection('Users');

  final String uid = auth.currentUser!.uid;

  final result = await users.doc(uid).get();
  return result.get('Civil ID');
}


Future<String> getDeviceID() async {
  final CollectionReference users = firestore.collection('Users');

  final String uid = auth.currentUser!.uid;

  final result = await users.doc(uid).get();
  return result.get('deviceID');
}

bool isRequestExist = false;

class SavingState extends State<Scan> {
  void _sumbitAuthForm(String DisNum, String UserID, BuildContext ctx) async {
    UserCredential authResult;
    print(DisNum);
    try {
      setState(() {
        _isLoading = true;
        isRequestExist = false;
        isExist = true;
        isSameUser  =false;
      });


      if (isExist) {


        final snapShot = await FirebaseFirestore.instance.collection('Cards').where('UserID', isEqualTo: auth.currentUser!.uid).get();


        await FirebaseFirestore.instance.collection("Cards").doc(UserID).get().then((value) {
          double b = double.parse(value.get("AvailableBalance"));
          double a = double.parse(value.get("RemainingAmount"));
          double c = double.parse(value.get("ActualBalance"));
          double A = double.parse(DisNum);
          b+= A;
          a+= A;
          c+= A;
          FirebaseFirestore.instance.collection("Cards").doc(UserID).update({
            "AvailableBalance": b.toString(),
            "RemainingAmount": a.toString(),
            "ActualBalance":  c.toString(),

          });

        });

          await FirebaseFirestore.instance.collection("Cards").doc(snapShot.docs[0].id).get().then((value) {
          double A = double.parse(DisNum);
          double B = double.parse(value.get("AvailableBalance"));
          double ST = double.parse(value.get("SavingTotal"));
          double R = double.parse(value.get("RemainingAmount")) - A;
          String isActive = value.get("isSaving");
          String isOne = value.get("Plan");

          double C = B - A;
          if (isActive == true.toString() && A % 1 != 0)
          {


            if (isOne == true.toString())
            {
              double rem = A - A.toInt();
              rem = 1 - rem;
              ST += rem;
              double F = C - 1;
              double D = R - 1;



              FirebaseFirestore.instance.collection("Cards").doc(snapShot.docs[0].id).update({
                "AvailableBalance": F.toString(),
                "RemainingAmount": D.toString(),
                "ActualBalance":  C.toString(),
                "SavingTotal":  ST.toString(),
              });
              DateTime dateTime = Timestamp.now().toDate();
              String date = DateFormat.yMd().add_jm().format(dateTime);

              FirebaseFirestore.instance.collection("Notifications").add({
                "CardNumber": value.get("CardNumber"),
                "AvailableBalance": C.toString(),
                "RemainingAmount": D.toString(),

                "amount": DisNum,
                "Time": Timestamp.now().toDate(),
                "message": "Your credit card " + value.get("CardNumber").toString().substring(15) + " has been debited with " + A.toString() +
                    "KWD from talabat on " + date + " Your remaining balance is " + C.toString() + " KWD",
                "UserID": FirebaseAuth.instance.currentUser!.uid,
                "isSelected": false.toString(),
                "Category": "Unknown",
              });
            }
            else
            {

              ST += 0.5;
              double F = C - 0.5;
              double D = R - 0.5;

              FirebaseFirestore.instance.collection("Cards").doc(snapShot.docs[0].id).update({
                "AvailableBalance": F.toString(),
                "RemainingAmount": D.toString(),
                "ActualBalance":  C.toString(),
                "SavingTotal":  ST.toString(),

              });
              DateTime dateTime = Timestamp.now().toDate();
              String date = DateFormat.yMd().add_jm().format(dateTime);

              FirebaseFirestore.instance.collection("Notifications").add({
                "CardNumber": value.get("CardNumber"),
                "AvailableBalance": F.toString(),
                "RemainingAmount": D.toString(),

                "amount": DisNum,
                "Time": Timestamp.now().toDate(),
                "message": "Your credit card " + value.get("CardNumber").toString().substring(15) + " has been debited with " + A.toString() +
                    "KWD from talabat on " + date + " Your remaining balance is " + C.toString() + " KWD",
                "UserID": FirebaseAuth.instance.currentUser!.uid,
                "isSelected": false.toString(),
                "Category": "Unknown",
              });
            }
          }
          else
            FirebaseFirestore.instance.collection("Cards").doc(snapShot.docs[0].id).update({
              "AvailableBalance": C.toString(),
              "ActualBalance": C.toString(),
              "RemainingAmount": R.toString(),
            });
          DateTime dateTime = Timestamp.now().toDate();
          String date = DateFormat.yMd().add_jm().format(dateTime);

          FirebaseFirestore.instance.collection("Notifications").add({
            "CardNumber": value.get("CardNumber"),
            "AvailableBalance": C.toString(),
            "RemainingAmount": R.toString(),

            "amount": DisNum,
            "Time": Timestamp.now().toDate(),
            "message": "Your credit card " + value.get("CardNumber").toString().substring(15) + " has been debited with " + A.toString() +
                "KWD from talabat on " + date + " Your remaining balance is " + C.toString() + " KWD",
            "UserID": FirebaseAuth.instance.currentUser!.uid,
            "isSelected": false.toString(),
            "Category": "Unknown",
          });

        });

        await

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Pay Successfully"),
              actions: [
                FlatButton(
                  textColor: Color(0xFF6200EE),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext ctx) => HomePage()),
                    );
                  },
                  child: Text('OK'),
                ),

              ],
            )
        );
      }


      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;

      });
      print(err);
    }
  }
  @override
  String qrCode = '';
  DateTime dateTime = DateTime.now();
  bool isSwitched = false;
  GlobalKey globalKey = new GlobalKey();
  String NewAmount = '';

  _contentWidget(String PN) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(

      child:  Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            child: Text(
              "To  receive money the sender should scan the code.",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 10.0,
            ),
            child:  Container(
              //height: _topSectionHeight,

            ),
          ),
          Expanded(
            child:  Center(

              child: RepaintBoundary(
                key: globalKey,
                child: Container(
                  color: Colors.white,
                  child: QrImage(
                    data: PN,
                    size: 0.5 * bodyHeight,

                  ),
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(bottom: 45),

            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton(
              onPressed: () {

                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          backgroundColor: Color (0xff343b4b),
                          title: Text("Amount:", style: TextStyle(
                              color: Color(0xff5496F4)
                          ),),
                          actions: [

                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                width: 300,
                                height: 50,
                                child: TextField(

                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.left,
                                  onChanged: (v) {
                                    NewAmount = v;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),


                            Center(
                              child: ElevatedButton(
                                onPressed: ()  async {
                                scanQRCode();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 15.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Scan',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                );
                },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 15.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Scan to pay',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
        print(this.qrCode);
      _sumbitAuthForm(NewAmount, this.qrCode  ,context);
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
  Widget build(BuildContext context) {
    return
      Scaffold(

        backgroundColor: Color(0xff161d2f),


        appBar: AppBar(

          backgroundColor: Color(0xff161d2f),
          title: Text("QR Code"),
          leading:  IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => HomePage()),),

          ),

        ),



        body: Container(

          alignment: Alignment.center,

          child: FutureBuilder (
              future: FirebaseFirestore.instance.collection('Cards')
                  .where("UserID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where("isSelected", isEqualTo: "true").get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                else
                {
                  return  Container(
                    //height: 200,
                      decoration: new BoxDecoration(
                      ),
                      child:
                            _contentWidget(snapshot.data!.docs[0].id),







                  );// Thi
                }
              }
          ),
        ),

      );
  }
}