import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:io';

import 'dart:convert';

//import '../../main.dart';
import 'Main.dart';
import 'package:intl/intl.dart';  //for date format
import 'package:intl/date_symbol_data_local.dart';

import 'MoneyManagement.dart';


class History extends StatefulWidget {
  NotificationsState createState() => new NotificationsState();

}

class NotificationsState extends State<History> {

  @override


  Widget build(BuildContext context) {

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
            double C = B - A;
            FirebaseFirestore.instance.collection("Cards").doc("Bp2iTDI0Zn2NN02DgQPq").update({
              "AvailableBalance": C.toString()
            });

            FirebaseFirestore.instance.collection("Notifications").add({
              "CardNumber": value.get("CardNumber"),
              "AvailableBalance": C.toString(),
              "amount": DisNum,
              "Time": Timestamp.now().toDate(),
              "message": value.get("CardNumber"),
              "UserID": FirebaseAuth.instance.currentUser!.uid,
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

    return new Scaffold(
      backgroundColor: Color(0xff161d2f),
      appBar: new AppBar(
        title: Text('History'),
        elevation: 5,
        backgroundColor: Color(0x01091C),
      ),
      body: Column(children: <Widget>[

        SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Notifications").where("isSelected", isEqualTo: "true")

              .snapshots(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                backgroundColor: Colors.grey,
              );
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot notification = snapshot.data!.docs[index];
                  Timestamp timestamp = notification.get("Time") as Timestamp;
                  DateTime dateTime = timestamp.toDate();
                  String date = DateFormat.yMd().add_jm().format(dateTime);



                  return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Color(0x4D515B),
                    elevation: 10,
                    margin: EdgeInsets.all(7),
                    child: Column(
                      children: <Widget>[

                        ListTile(
                          trailing: Text(notification.get("Category") + '\n' + 'Starting Balance: ' + notification.get("SB")
                              + '\n' + 'Current Balance: ' + notification.get("CB"),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),

                        ),
                        Container(
                          decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                            //border: Border.all(color: Colors.black,width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0x4D515B),
                          ),
                          margin: EdgeInsets.all(12.5),
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: Text(notification.get("message"),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14,color: Colors.white))),


                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ]),
    );


  }
}
