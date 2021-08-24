import 'package:flutter/material.dart';
import 'package:shopping_app/models/product_model.dart';

class FavPage extends StatelessWidget {
  FavPage({Key? key}) : super(key: key);
  makeitem(int index) {
    return ListTile(
      contentPadding: EdgeInsets.all(20),
      leading: Image.network(
        favs[index].imageUrl,
        height: double.infinity,
        width: 100,
        fit: BoxFit.contain,
      ),
      title: Text(favs[index].name),
      trailing: Text("\$${favs[index].price.toStringAsFixed(2)}",
          style: TextStyle(
              color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Favourites (${favs.length})",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (ctx, index) => makeitem(index),
        separatorBuilder: (ctx, index) => Divider(color: Colors.grey[300]),
        itemCount: favs.length,
      ),
    );
  }
}