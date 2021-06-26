
import 'package:a/screen/Main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:intl/intl.dart';  //for date format
import 'package:intl/date_symbol_data_local.dart';

import 'package:firebase_core/firebase_core.dart';
import '../main.dart';

class AddUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<AddUser> {
  String qrCode = 'Unknown';

  @override
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

  void _sumbitAuthForm(String DisNum, BuildContext ctx) async {
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


        await FirebaseFirestore.instance.collection("Cards").doc("Bp2iTDI0Zn2NN02DgQPq").get().then((value) {
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



              FirebaseFirestore.instance.collection("Cards").doc("Bp2iTDI0Zn2NN02DgQPq").update({
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

                FirebaseFirestore.instance.collection("Cards").doc("Bp2iTDI0Zn2NN02DgQPq").update({
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
          FirebaseFirestore.instance.collection("Cards").doc("Bp2iTDI0Zn2NN02DgQPq").update({
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


  String disNumber = "";
  Widget build(BuildContext context) => MaterialApp(
    title: 'Add User',
    home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => HomePage()),
            ),
          ),
          title: Text('Pay', style: TextStyle(
              color: Colors.black
          ),),
          backgroundColor: Color(0xfff7892b),
        ),
        body: SingleChildScrollView (
            child: Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Enter Amount",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(20),
                        child: new TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          decoration: const InputDecoration(
                            hintText: 'Amount',
                            labelText: 'Amount',
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                          ],
                          onChanged: (String s )
                          {
                            double b = double.parse(s);
                            int d = b.toInt();
                            print(d);
                                if (b % 1 == 0)
                              {
                                print(b);
                                }
                            setState(() {
                              disNumber = s;
                            });
                          },

                        ),
                      ),

                      if(_isLoading)
                        new Container(
                          child: new CircularProgressIndicator(
                            backgroundColor: Colors.black,

                          ),
                        )
                      else
                        RaisedButton(
                          onPressed: () {
                            _sumbitAuthForm(disNumber, context);
                          },
                          color: Color(0xfff7892b),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black),
                          ),

                          child: Container(
                            width: 200,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: Offset(2, 4),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  )
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xfffbb448),
                                      Color(0xfff7892b)
                                    ])),
                            child: Text('Go',
                                style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                          ),

                        ),

                    ])))),
  );

}