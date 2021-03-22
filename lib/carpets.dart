import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:info802_flutter_app/main.dart';
import 'soap.dart';
import 'product.dart';
import 'payment.dart';
import 'package:url_launcher/url_launcher.dart';

class CarpetsView extends StatefulWidget {
  CarpetsView({Key key, this.product}) : super(key: key);
  final Product product;

  @override
  _CarpetsViewState createState() => _CarpetsViewState();
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _CarpetsViewState extends State<CarpetsView> {
  double frais = 0;
  double totalCost = 0;
  String userID = "";
  String redirectURL = "";
  final firstNameController = TextEditingController();
  final nameController = TextEditingController();

  changeText() {
    getFromSoap(widget.product.weight, widget.product.price).then((value) => setState(() {
          frais = value;
          totalCost = (frais + widget.product.price) * 100;
        }));
  }

  payAmount() {
    createNaturalUser(firstNameController.text, nameController.text).then((value) => setState(() {
          userID = value;
        }));
    pay(userID, totalCost).then((value) => setState(() {
          redirectURL = value;
          launchURL(redirectURL);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Achat d'un " + widget.product.name,
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(bottom: 50.0, left: 10, right: 10),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 50.0),
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: ElevatedButton(
                            onPressed: () {
                              changeText();
                            },
                            child: Text('Calculer frais de livraison')),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("Prix de votre article : " + widget.product.price.toString() + " €"),
                      Text("Frais de livraison : " + frais.toString() + " €"),
                      Text("Coût total  : " + (totalCost / 100).toString() + " €"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 50.0, left: 10, right: 10, top: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Prénom',
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nom',
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            payAmount();
                          },
                          child: Text("Payer")),
                    ],
                  ),
                )
              ])),
        ],
      ),
    );
  }
}
