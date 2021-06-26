import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              height: 220,
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      cryptoIcon(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      cryptoNameSymbol(),
                                      Spacer(),
                                      cryptoChange(),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      changeIcon(),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[cryptoAmount()],
                                  )
                                ],
                              ))
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            )));
  }
  Widget cryptoIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            CryptoFontIcons.BTC,
            color: Colors.amber,
            size: 40,
          )),
    );
  }
  Widget cryptoNameSymbol() {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: 'tg',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: 'rf',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  Widget cryptoChange() {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: 're',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: '',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  Widget changeIcon() {
    return Align(
        alignment: Alignment.topRight,
        child: Icon(
          Typicons.arrow_sorted_up,
          color: Colors.green,
          size: 30,
        ));
  }
  Widget cryptoAmount() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: 'cd',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'g',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}