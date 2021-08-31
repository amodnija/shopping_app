import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sizer/sizer.dart';

class ProductCarousal extends StatelessWidget {
  final String title;
  final List? products;

  ProductCarousal({required this.title, required this.products});

  _product(int index) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: 80.0.w,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black54, offset: Offset(0.0, 2.0), blurRadius: 6),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(
                products![index].imageUrl,
                fit: BoxFit.contain,
                height: 40.h,
                width: 70.w,
              ),
            ),
          ),
          AutoSizeText(products![index].name,
              minFontSize: 10,
              maxLines: 2,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '\₹${products![index].price.toString()}',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                FlatButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.teal,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                      ),
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add to cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                      )
                    ],
                  ),
                  onPressed: () {
                    if (!cart.contains(products![index])) {
                      cart.add(products![index]);
                      Fluttertoast.showToast(msg: "Added to cart");
                    }
                  },
                ),
                FlatButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.teal,
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                      ),
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Favourite",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                      )
                    ],
                  ),
                  onPressed: () {
                    if (!favs.contains(products![index])) {
                      favs.add(products![index]);
                      Fluttertoast.showToast(msg: "Added to Favourites");
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        Container(
          height: 80.h,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: products!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return _product(index);
              }),
        )
      ],
    );
  }
}
