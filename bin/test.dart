import 'dart:convert';

import 'package:http/http.dart' as http;

main() async {
  //get
  var response = await http.get(Uri.parse('http://127.0.0.1:8000/core/'));
  //post
  var rsp = await http.post(Uri.parse('http://127.0.0.1:8000/core/'),body: {
    'username':'mandem',
    'email':'mandem@mandem.com'
  });
  // print(response.body);
  print(jsonDecode(response.body)['username']);
}
