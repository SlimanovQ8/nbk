import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(

        backgroundColor: Color(0xff161d2f),
          /*drawer: Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50.0,),
                  ),
                  accountName: Text('User Name'),
                  accountEmail: Text('examlpe@gmail.com'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person_outline,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Profile Settings"),
                  onTap: () {

                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.settings,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Settings"),
                  onTap: () {

                  },
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.help_outline,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("About us"),
                  onTap: () {},
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.cached,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Recenceter"),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
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
          ),*/


          appBar: AppBar(

            backgroundColor: Color(0xff161d2f),
            title: Text("My Account"),
            leading:  IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, ),

              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => HomePage()),),


            ),
            actions: [
              Icon(Icons.settings),
              Icon(Icons.search),
              Icon(Icons.more_vert),

            ],


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
                              [ Text("total balance",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15,
                                      color: Colors.white,
                                    )),
                                Row(
                                    children:<Widget> [
                                      Icon(Icons.visibility_off),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text("**** KD",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14,
                                            color: Colors.white,
                                          )),


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
                                Text("9,000.000 KD",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,
                                      color: Colors.white,
                                    )),
                              ]
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                      children: <Widget> [Expanded(
                          child:
                          ImageIcon(
                            AssetImage("images/nbkLogo.png"),

                            size: 40,
                          ),
                      ),]
                  ),
                ],
              ),
            ),
          ) // This trailing

      );
  }
}