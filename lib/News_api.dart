import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;



class NewsPage extends StatelessWidget {
  Future<String> fetchnews() async{
    String apikey = '24c5a60e9a924705938d1cac2101590f';
    String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey="+apikey;

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      // print("hh"+jsonResponse['articles'].toString());
      return response.body;
    }
    else {
      return 'Request failed with status: ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchnews(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              Text(snapshot.data.toString())
            ],
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
