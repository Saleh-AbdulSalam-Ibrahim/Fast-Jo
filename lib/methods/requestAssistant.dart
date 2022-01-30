import 'dart:convert';

import 'package:http/http.dart' as http;


class RequestAssistant
{

  static Future<dynamic> getRequest(String url) async
  {
    http.Response response = await http.get(Uri.parse(url));

    try
    {
      if (response.statusCode == 200)
      {
        String jSondata = response.body;
        return jsonDecode(jSondata);
      }
      else
      {
        print(response.statusCode);
        return 'failed';
      }
    }
    catch(exp)
    {
      print('Exp Error :$exp ');
      return 'failed';
    }

  }


}




