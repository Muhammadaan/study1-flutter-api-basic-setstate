import 'package:flutter/material.dart';

class CartProduct extends StatefulWidget {
  final List cart;
  const CartProduct({super.key, required this.cart});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listCart = widget.cart;
  }

  List listCart = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: listCart.asMap().entries.map((e) {
              int index = e.key;
              Map item = e.value;

              return Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.network(
                      "http://192.168.1.14:8000/images/" + item['image'],
                      width: 70,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text(item['price']),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          listCart.removeAt(index);
                          setState(() {});
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
