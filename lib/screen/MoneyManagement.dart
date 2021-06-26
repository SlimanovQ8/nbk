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


class MoneyManagement extends StatefulWidget {
  MM createState() => new MM();

}

class MM extends State<MoneyManagement> {

  @override

  var count = 0;
  final firestore = FirebaseFirestore.instance; //
  FirebaseAuth auth = FirebaseAuth.instance;
  String Cate = '';

  bool isEmpty  = false;
  String NewAmount = '';

  bool edit = true;

  void _Update (String nm, String S1, String S2)async {
    setState(() {
      FirebaseFirestore.instance.collection('Cards').
      doc(S1).collection('Category').doc(S2).update({
        "Amount": NewAmount,

      });
    });

  }
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
      body: FutureBuilder (
        future: FirebaseFirestore.instance.collection('Cards')
            .where("UserID", isEqualTo: auth.currentUser!.uid)
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
            return Container (
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
                    child: Card(


                      color: Color(0xff343b4b),

                      clipBehavior: Clip.antiAlias,

                      elevation: 10,
                      margin: EdgeInsets.all(7),
                      child: Column(
                        children: <Widget>[
                          ListTile(

                            title: Text("Main Account" + snapshot.data!.docs[0].get("CardNumber").substring(14),


                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                            subtitle: Text("  Available Balance \n " + snapshot.data!.docs[0].get('AvailableBalance').toString().substring(0,  snapshot.data!.docs[0].get('AvailableBalance').toString().indexOf('.') + 2)
                                + "\n Remaining Balance \n " + snapshot.data!.docs[0].get("RemainingAmount").toString().substring(0,  snapshot.data!.docs[0].get('RemainingAmount').toString().indexOf('.') + 2)
                              ,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
                          ),

                        ],
                      ),
                    ),

                  ),


                  Container(
                    child: Text("My Categories",   style: TextStyle(
                        color: Colors.white,
                        fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.right,),

                  ),
                  SizedBox( height: 8,),
                  FutureBuilder(
                      future: FirebaseFirestore.instance.
                      collection("Cards").doc(snapshot.data!.docs[0].id)
                          .collection('Category')
                          .get(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> q) {
                        if (q.data == null) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (q.data!.docs.length == 0) {
                          return Container(
                          );
                        }
                        else {
                          return  Container(
                            child: Expanded(
                              child: ListView.builder(

                                  itemCount: q.data!.docs.length,
                                  itemBuilder: (context, i)
                                  {


                                    return Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        secondaryActions: <Widget>[
                                          IconSlideAction(
                                              caption: "update",
                                              color: Colors.yellow,
                                              icon: Icons.update,
                                              onTap: () async
                                              {
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
                                                                  if (NewAmount == '')
                                                                  {
                                                                    setState(() {
                                                                      isEmpty == true;
                                                                    });
                                                                  }
                                                                  else {


                                                                    double c = 0;
                                                                    String s1 = snapshot.data!.docs[0].id;
                                                                    String s2 = q.data!.docs[i].id;

                                                                    setState(() {
                                                                      FirebaseFirestore.instance.collection('Cards').
                                                                      doc(s1).collection('Category').doc(s2).update({
                                                                        "Amount": NewAmount,

                                                                        "SB": NewAmount,
                                                                      }).whenComplete(() {
                                                                        for(var b = 0; b < q.data!.docs.length; b++)
                                                                        {
                                                                          if (b==i)
                                                                            c += double.parse(NewAmount);
                                                                          else
                                                                          c += double.parse(q.data!.docs[b].get("Amount"));

                                                                        }
                                                                        double All = double.parse(snapshot.data!.docs[0].get("AvailableBalance")) - c;


                                                                        FirebaseFirestore.instance.collection('Cards').
                                                                        doc(snapshot.data!.docs[0].id).update({"RemainingAmount": All.toString(),
                                                                        });
                                                                        setState(() {

                                                                        });
                                                                      });
                                                                    });

                                                                    Navigator.pop(context);
                                                                  };
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
                                                                    'Save',
                                                                    style: TextStyle(fontSize: 20),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                );

                                              }
                                          ),
                                          IconSlideAction(
                                            caption: "delete",
                                            color: Colors.red,
                                            icon: Icons.delete,
                                            onTap: ()
                                            {

                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      AlertDialog(
                                                        backgroundColor: Color (0xff343b4b),
                                                        title: Text("Delete Category", style: TextStyle(

                                                            color: Color(0xff5496F4)
                                                        ),),
                                                        content: Text("Are you sure want to delete " + q.data!.docs[i].get('CategoryName') + " Category", style: TextStyle(

                                                            color: Color(0xff5496F4)
                                                        ),),
                                                        actions: [

                                                          TextButton(onPressed: () {
                                                            setState(() {
                                                              double b = double.parse(snapshot.data!.docs[0].get("RemainingAmount"));
                                                              double a = double.parse(q.data!.docs[i].get("Amount"));
                                                              double c = a + b;
                                                              FirebaseFirestore.instance.collection("Cards").doc(snapshot.data!.docs[0].id).update({
                                                                "RemainingAmount": c.toString(),
                                                              });
                                                              

                                                            });
                                                            setState(()  {
                                                              FirebaseFirestore.instance.collection('Cards')
                                                                  .doc(snapshot.data!.docs[0].id)
                                                                  .collection("Category").doc(q.data!.docs[i].id).delete();
                                                            });
                                                            Navigator.pop(context);

                                                          },

                                                            child: Text("Yes", style: TextStyle(
                                                                color: Colors.red
                                                            ),),
                                                          ),
                                                          TextButton(onPressed: () {
                                                            setState(() {
                                                              Navigator.pop(context);
                                                            });

                                                          },

                                                            child: Text("No", style: TextStyle(
                                                                color: Colors.lightGreen
                                                            ),),
                                                          ),

                                                        ],
                                                      )
                                              );
                                            },
                                          ),

                                        ],
                                        actionExtentRatio: 1/5,
                                        child: Card(color: Color(0xff343b4b), child: Container(

                                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15), child: Column(
                                            mainAxisSize: MainAxisSize.min,

                                            children: [
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(q.data!.docs[i].get('CategoryName'), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,
                                                        fontSize: 30),),

                                                    Column(
                                                      children: [
                                                        SizedBox(height: 20,),
                                                        Text("Amount", textAlign: TextAlign.right,
                                                          style: TextStyle(color: Colors.white, fontSize: 18),)

                                                      ],

                                                    )
                                                  ]
                                              ),
                                              SizedBox(height: 18,),

                                              Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black),
                                                    borderRadius: BorderRadius.circular(2),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                                  child: new FormField(builder: (FormFieldState state) {
                                                    return InputDecorator(
                                                      decoration: InputDecoration(

                                                          labelText: q.data!.docs[i].get("Amount")+ " KD"
                                                          ,
                                                          labelStyle: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 40
                                                          )
                                                      ),
                                                    );

                                                  })
                                              )
                                            ]),
                                        ),
                                        )
                                    );
                                  }
                              ),
                            ),
                          );
                        }
                      }
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
                                  title: Text("Category Name", style: TextStyle(
                                      color: Color(0xff5496F4)
                                  ),),
                                  actions: [

                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      child: TextField(

                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left,
                                        onChanged: (v) {
                                          Cate = v;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),


                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (Cate == '')
                                          {
                                            setState(() {
                                              isEmpty == true;
                                            });
                                          }
                                          else
                                            setState(() {

                                              FirebaseFirestore.instance.collection('Cards').
                                              doc(snapshot.data!.docs[0].id).collection('Category')
                                                  .add({
                                                "CategoryName": Cate,
                                                "Amount": "0",
                                                "Editable": false.toString()
                                              });
                                              Navigator.pop(context);
                                            });
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
                                            'Add Category',
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
                          'Add Category',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            );
        },),);


  }
}
