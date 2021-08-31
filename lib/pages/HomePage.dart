import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/pages/CartPage.dart';
import 'package:shopping_app/pages/FavPage.dart';
import 'package:shopping_app/widgets/productcarousal.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'RegPage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> setProducts() async {
      products = await getData();
  }

  @override
  void initState() {
    setProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setProducts(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 5.0,
              leading: Padding(
                padding: EdgeInsets.only(left: 20),
                child: InkResponse(
                  onTap: () async {
                    final User? user = await _auth.currentUser;
                    if (!(user == null)) {
                      await _auth.signOut();
                      Fluttertoast.showToast(msg: "Signed out successfully");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RegScreen()));
                    }
                  },
                  child: Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.teal,
                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Shopping App',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ),
              centerTitle: true,
              actions: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, right: 20),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => CartPage()));
                        },
                        child: Icon(
                          Icons.shopping_cart,
                          size: 30,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: InkResponse(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => FavPage()));
                    },
                    child: Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
            body: ListView(
              children: <Widget>[
                ProductCarousal(
                  title: "Items in our inventory:",
                  products: products,
                ),
              ],
            ),
          );
        });
  }
}
