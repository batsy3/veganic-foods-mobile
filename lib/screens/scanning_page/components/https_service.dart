import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/screens/details_page/details.dart';

import '../../details_page/components/product_class.dart';
import '../scan.dart';

class Httpp extends StatefulWidget {
  final String? id;
  const Httpp({Key? key, required this.id}) : super(key: key);

  @override
  State<Httpp> createState() => _HttppState();
}

class _HttppState extends State<Httpp> {
  late Future<Product> _future ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = _getdata(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _future,
          builder: (context, AsyncSnapshot<Product> snapshot) {
            if (snapshot.hasData) {
              Product? data = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(
                                  product_id: data!.product_id,
                                  category: data.category,
                                  name: data.name,
                                  quantity: data.quantity,
                                  price: data.price,
                                  description: data.description,
                                  image: data.image,
                                )));
                  });
                  break;
                case ConnectionState.none:
                  return NetworkErrorpage();
                default:
                  return Center(
                    child: Text('error'),
                  );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  backgroundColor: bGcolor,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              );
              ;
            }
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 6,
                backgroundColor: bGcolor,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          }),
    );
  }
}

const String postUrl = "http://192.168.235.5:8007/api/product";
Future<Product> _getdata(String? id) async {
  String url = postUrl + '/$id';
  var res = await http.get(Uri.parse(url));
  if (res.statusCode == 200) {
//==================================================================
    Map<String, dynamic> productMap = jsonDecode(res.body);
    var products = Product.fromJson(productMap);
    print(products.toJson());
    return products;
//====================================================================
  } else
    return Circle();
  // return NetworkErrorpage();
}

dynamic Circle() {
  return CircularProgressIndicator();
}

dynamic NetworkErrorpage() {
  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/1_No Connection.png",
          fit: BoxFit.cover,
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 90),
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(300, 59),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              primary: Color(0xFF6B92F2),
              onPrimary: Colors.white,
            ),
            onPressed: () {
              Get.to(ScanningPage());
            },
            child: Text('scan again',
                maxLines: 3,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
        )
      ],
    ),
  );
}
