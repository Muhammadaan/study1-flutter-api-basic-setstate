import 'dart:convert';
import 'dart:developer';

import 'package:fapi/product/cartProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class ListBook extends StatefulWidget {
  const ListBook({super.key});

  @override
  State<ListBook> createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Product"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartProduct(
                            cart: listCart,
                          )),
                );
              },
              icon: Badge.count(
                count: listCart.length,
                child: FaIcon(
                  FontAwesomeIcons.cartShopping,
                  size: 20,
                ),
              ))
        ],
      ),
      body: Container(
        child: GridView.builder(
          itemCount: listdata.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final e = listdata[index];
            return InkWell(
              onTap: () {
                addToCart(e);
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "http://192.168.1.14:8000/images/" + e['image'],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(e['price']),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Logic

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("init");
    getBook();
  }

  List listdata = [];
  List listCart = [];

  getBook() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.14:8000/api/products"));
    var responseData = json.decode(response.body);
    listdata = responseData['data'];
    setState(() {});
  }

  addToCart(Map product) {
    listCart.add(product);
    setState(() {});
  }
}
