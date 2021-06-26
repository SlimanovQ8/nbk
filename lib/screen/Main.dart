import 'package:a/screen/MoneyManagement.dart';
import 'package:a/screen/Pay.dart';
import 'package:a/screen/Scan.dart';
import 'package:a/screen/history.dart';
import 'package:a/screen/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  //for date format


import 'Saving.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(

        backgroundColor: Color(0xff161d2f),
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50.0,),
                  ),
                  accountName: Text('Suliman Al-Mamari'),
                  accountEmail: Text('slimanovq8@gmail.com'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.history,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("History"),
                  onTap: () {

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => History()),);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.notifications_on,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Notifications"),
                  onTap: () {

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => Notifications()),);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.monetization_on,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("MoneyManagement"),
                  onTap: () {


                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => MoneyManagement()),);



                  },
                ),

                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.payment,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Pay"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => AddUser()),);

                  },
                ),

                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.qr_code,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Scan"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => Scan()),);


                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.savings,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Saving Plan"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => Saving()),);

                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.exit_to_app,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Logout"),
                  onTap: ()
                  {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),


          appBar: AppBar(

            backgroundColor: Color(0xff161d2f),
            title: Text("My Account"),




          ),



          body:  FutureBuilder (
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
          return Container(
            height: 200,
            decoration: new BoxDecoration(
            ),
            child: Card(

              color: Color(0xff343b4b),

              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 10,
              margin: EdgeInsets.all(7),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading:
                    ImageIcon(
                      AssetImage("images/nbkLogo.png"),

                      size: 80,
                      color: Colors.white,
                    ),
                    title: Text("Card Number " + snapshot.data!.docs[0].get("CardNumber").toString().substring(15),



                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              //      subtitle: ,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      //border: Border.all(color: Colors.black,width: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.all(12.5),
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Column(
                              children:<Widget>
                              [ Text("Total balance",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15,
                                      color: Colors.white,
                                    )),
                                Row(
                                    children:<Widget> [
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(snapshot.data!.docs[0].get("ActualBalance").toString().substring(0, snapshot.data!.docs[0].get("ActualBalance").toString().indexOf('.') + 2) +" KD",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14,
                                            color: Colors.white,
                                          )),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      GestureDetector(child: Icon(Icons.info_outline), onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  backgroundColor: Color (0xff343b4b),
                                                  title: Text("total balance", style: TextStyle(

                                                      color: Color(0xff5496F4)
                                                  ),),
                                                  content: Text("Total balance without applying the saving rules", style: TextStyle(

                                                      color: Color(0xff5496F4)
                                                  ),),
                                                  actions: [

                                                    TextButton(onPressed: () {
                                                      Navigator.pop(context);
                                                    },

                                                      child: Text("OK", style: TextStyle(
                                                          color: Colors.red
                                                      ),),
                                                    ),
                                                  ],
                                                )
                                        );
                                      },)


                                    ]
                                ),
                              ]
                          ),
                        ),
                        Expanded(
                          child: Column(
                              children:<Widget>
                              [ Text("Available balance",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15,
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                  width: 40,
                                ),
                                Row(
                                    children:<Widget> [
                                      //Icon(Icons.visibility_off),

                                      Text(snapshot.data!.docs[0].get("AvailableBalance").toString().substring(0, snapshot.data!.docs[0].get("AvailableBalance").toString().indexOf('.') + 2) +" KD",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14,
                                            color: Colors.white,
                                          )),


                                    ]
                                ),
                              ]
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ); // This trailing
        }
    }
          )


      );
  }
}