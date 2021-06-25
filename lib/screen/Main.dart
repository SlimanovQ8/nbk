import 'package:a/screen/MoneyManagement.dart';
import 'package:a/screen/Pay.dart';
import 'package:a/screen/history.dart';
import 'package:a/screen/notifications.dart';
import 'package:flutter/material.dart';

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
                    child: Icon(Icons.exit_to_app,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Logout"),
                ),
              ],
            ),
          ),


          appBar: AppBar(

            backgroundColor: Color(0xff161d2f),
            title: Text("My Account"),




          ),



          body: Container(
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

                      size: 90,
                    ),
                    title: Text("Main Account 123456",


                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
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
                          width: 100,
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
                                      Text("**** KD",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14,
                                            color: Colors.white,
                                          )),
                                      SizedBox(
                                        width: 5,
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
                                Row(
                                    children:<Widget> [
                                      //Icon(Icons.visibility_off),

                                      Text("9,000.000 KD",
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
          ) // This trailing

      );
  }
}