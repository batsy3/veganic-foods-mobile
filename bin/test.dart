import 'dart:convert';

import 'package:http/http.dart' as http;

main() async {
  //get
  final String mainUrl = 'http://192.168.40.100:8000/products';

  var response =
      await http.get(Uri.parse('http://192.168.40.100:8000/products'));
  //post
  // var rsp = await http.post(Uri.parse('http://127.0.0.1:8000/core/'),body: {
  //   'username':'mandem',
  //   'email':'mandem@mandem.com'
  // });
  // print(response.body);
  print(jsonDecode(response.body)[0]['name']);
}
