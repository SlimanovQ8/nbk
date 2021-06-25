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
import 'dart:io';

import 'dart:convert';

import '../../main.dart';
import 'Main.dart';


class MoneyManagement extends StatefulWidget {
  MM createState() => new MM();

}

class MM extends State<MoneyManagement> {

  @override

  var count = 0;
  final firestore = FirebaseFirestore.instance; //
  FirebaseAuth auth = FirebaseAuth.instance;


  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xff161d2f),

    appBar: AppBar(

    backgroundColor: Color(0xff161d2f),
    title: Text("Money Management"),
    leading:  IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white, ),

    onPressed: () => Navigator.of(context).push(
    MaterialPageRoute(builder: (ctx) => HomePage()),),


    ),
    ),
        body: Container (
          child: Column (
            children: <Widget> [
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "Source Account",

                  style: TextStyle(fontSize: 30,
                      color: Color(0xff8aa1ba)),
                ),
              ),
              Container(
                height: 100,
                child: Card(


                  color: Color(0xff343b4b),

                  clipBehavior: Clip.antiAlias,

                  elevation: 10,
                  margin: EdgeInsets.all(7),
                  child: Column(
                    children: <Widget>[
                      ListTile(

                        title: Text("Main Account 123456",


                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                        subtitle: Text("  Available Balance \n 10.000.9 KWD" ,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
                      ),

                    ],
                  ),
                ),

              ),Container(
                height: 100,
                child: Card(


                  color: Color(0xff343b4b),

                  clipBehavior: Clip.antiAlias,

                  elevation: 10,
                  margin: EdgeInsets.all(7),
                  child: Column(
                    children: <Widget>[
                      new ListTile(

                        title: Text("Loans",


                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                        trailing: new Container(
                          width: 150.0,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Expanded(
                                flex: 3,
                                child: TextField(

                                  style: TextStyle(fontFamily: 'semibold', color: Colors.white),
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(contentPadding:EdgeInsets.all(8.0),
                                    hintStyle: TextStyle(fontFamily: 'semibold',),
                                    border: InputBorder.none,),
                                  ),
                              ),
                              new Expanded(
                                child: new IconButton(
                                  icon: new Icon(Icons.chevron_right),
                                  color: Colors.black26,
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              ),

            ],
          ),
        )
    );
  }
}
