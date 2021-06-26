import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Saving extends StatefulWidget {
  SavingState createState() => new SavingState();

}

class SavingState extends State<Saving> {
  @override
  DateTime dateTime = DateTime.now();
  bool isSwitched = false;
  Widget build(BuildContext context) {
    return
      Scaffold(

          backgroundColor: Color(0xff161d2f),

          appBar: AppBar(

            backgroundColor: Color(0xff161d2f),
            title: Text("Saving Rules"),

          ),



          body: FutureBuilder (
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
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            tileColor: Color(0xff343b4b),
                            title: Text('Choose Ending Date',style: TextStyle(
                                color: Colors.white
                            )),
                            trailing: InkWell(
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(4000),
                                );
                                if (date != null) {
                                  setState(() {
                                    dateTime = date;
                                  });
                                }
                              },
                              child: Text(dateTime == null
                                  ? 'Select Date'
                                  : '${dateTime.day} - ${dateTime.month} - ${dateTime.year}',style: TextStyle(
                                  color: Colors.white
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            tileColor: Color(0xff343b4b),
                            title: Text('Saving amount: ' + snapshot.data!.docs[0].get("SavingTotal").toString().substring(0, snapshot.data!.docs[0].get("SavingTotal").toString().indexOf('.') + 2) +" KD"
                                ,style: TextStyle(
                                color: Colors.white
                            )),

                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Text('Save the remaining to the nearest:  ',style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                ),
                                Text('0.5KD',style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white
                                )),
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                      print(isSwitched);
                                    });
                                  },
                                  activeTrackColor: Colors.green,
                                  activeColor: Colors.green,
                                ),
                                Text('1KD',style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white
                                )),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 45),

                            width: MediaQuery.of(context).size.width * 0.6,
                            child: ElevatedButton(
                              onPressed: () {

                                FirebaseFirestore.instance.collection("Cards").doc("Bp2iTDI0Zn2NN02DgQPq").update({
                                  "isSaving": true.toString(),
                                  "Plan": isSwitched.toString(),
                                  "endDate": dateTime,
                                });
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          backgroundColor: Color (0xff343b4b),
                                          title: Text("Your Saving plan has been started", style: TextStyle(

                                              color: Color(0xff5496F4)
                                          ),),
                                          content: Text("Now the Available balance will be shown next to the total balance", style: TextStyle(

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
                                  'Confirm Rules',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),


                        ],
                      )
                  );// Thi
                }
              }
          ),

      );
  }
}