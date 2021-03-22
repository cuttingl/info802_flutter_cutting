import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'product.dart';
import 'carpets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product product1 = new Product(weight: 20, name: "Tapis Mirzam", price: 390, quantity: 10);
    Product product2 = new Product(weight: 25, name: "Tapis Vintage Vega d'Orient", price: 133, quantity: 10);
    Product product3 = new Product(weight: 30, name: "Tapis Kazak Simav", price: 270, quantity: 10);
    Product product4 = new Product(weight: 35, name: "Tapis Rond Ziegler", price: 311, quantity: 10);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Carpet Seller',
        product1: product1,
        product2: product2,
        product3: product3,
        product4: product4,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.product1, this.product2, this.product3, this.product4}) : super(key: key);

  final String title;
  final Product product1;
  final Product product2;
  final Product product3;
  final Product product4;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: CustomScrollView(slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarpetsView(
                                  product: widget.product1,
                                )));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      children: [
                        Text(widget.product1.name),
                        Image.asset(
                          'assets/images/tapis_mirzam.jpg',
                          height: 300,
                          width: 300,
                        ),
                        Text("prix : " + widget.product1.price.toString() + " €")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarpetsView(
                                  product: widget.product2,
                                )));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      children: [
                        Text(widget.product2.name),
                        Image.asset(
                          'assets/images/tapis_vintage_orient.jpg',
                          height: 300,
                          width: 300,
                        ),
                        Text("prix : " + widget.product2.price.toString() + " €")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarpetsView(
                                  product: widget.product3,
                                )));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      children: [
                        Text(widget.product3.name),
                        Image.asset(
                          'assets/images/tapis_kazak_simav.jpg',
                          height: 300,
                          width: 300,
                        ),
                        Text("prix : " + widget.product3.price.toString() + " €")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarpetsView(
                                  product: widget.product4,
                                )));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      children: [
                        Text(widget.product4.name),
                        Image.asset(
                          'assets/images/tapis_ziegler_rond.jpg',
                          height: 200,
                          width: 200,
                        ),
                        Text("prix : " + widget.product4.price.toString() + " €")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
