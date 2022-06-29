import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/providers/Api_provider.dart';
import 'package:veganic_foods_app/screens/details_page/details.dart';
import '../../../widgets/network_error_page.dart';
import '../../details_page/components/product_class.dart';

class Httpp extends StatefulWidget {
  final String? id;
  const Httpp({Key? key, required this.id}) : super(key: key);

  @override
  State<Httpp> createState() => _HttppState();
}

class _HttppState extends State<Httpp> {
  late Future<Product> _future;
  @override
  void initState() {
    super.initState();
    _future = ApiProvider().getProduct(widget.id);
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


dynamic Circle() {
  return CircularProgressIndicator();
}


