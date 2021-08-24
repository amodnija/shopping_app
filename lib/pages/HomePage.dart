
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/pages/CartPage.dart';
import 'package:shopping_app/pages/FavPage.dart';
import 'package:shopping_app/widgets/productcarousal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: InkResponse(
            onTap: () {},
            child: Icon(
              Icons.menu,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Shopping App',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
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
                    color: Colors.black,
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
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ProductCarousal(
            title: "Available Items",
            products: products,
          ),
        ],
      ),
    );
  }
}
