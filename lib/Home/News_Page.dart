import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:intl/intl.dart';


Color primaryColor=Colors.green;
int? Country;

var colors = [Colors.blue,Colors.orange,Colors.pink,Colors.deepPurple,Colors.green,Colors.black54];
var countries = {'Argentina' : 'ar', 'Australia' : 'au', 'Brazil' : 'br', 'Canada' : 'ca', 'China' : 'cn', 'France' : 'fr', 'Germany' : 'de', 'Hong Kong' : 'hk', 'India' : 'in', 'Israel' : 'il', 'Italy' : 'it', 'Japan' : 'jp', 'Malaysia' : 'my', 'Netherlands' : 'nl', 'New Zealand' : 'nz', 'Nigeria' : 'ng', 'Philippines' : 'ph', 'Russia' : 'ru', 'Saudi Arabia' : 'sa', 'Serbia' : 'rs', 'Singapore' : 'sg', 'South Africa' : 'za', 'South Korea' : 'kr', 'Switzerland' : 'ch', 'Taiwan' : 'tw', 'Thailand' : 'th', 'Turkey' : 'tr', 'United Kingdom' : 'gb', 'United States' : 'us',};


Future getcolor() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? idx = prefs.getInt('color');
  print("color index = ${idx}");
  primaryColor = idx.runtimeType!=int?Colors.green:colors[idx!];
  // setState(() {
  //   // Navigator.pushReplacementNamed(context, '/settings',arguments: idx);
  //   print("primarycolor = ${primaryColor}");
  // });
}

Future SetColor({int idx=1}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('color');
  await prefs.setInt('color', idx);
}

Future getCountry() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? idx = prefs.getInt('country');
  print("country index = ${idx}");
  Country = idx.runtimeType!=int?9:idx;
}

Future SetCountry({int idx=9}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('country');
  await prefs.setInt('country', idx);
}

Future<String> fetchnews() async{
  String apikey = '24c5a60e9a924705938d1cac2101590f';
  String url = "https://newsapi.org/v2/top-headlines?country=${countries.values.toList()[Country!-1]}&apiKey="+apikey;

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body;
  }
  else {
    return 'Request failed with status: ${response.statusCode}';
  }
}

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var colors = [Colors.blue,Colors.orange,Colors.pink,Colors.deepPurple,Colors.green,Colors.black54];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcolor();
    getCountry();
  }

  // format_datetime(date_time){
  //   return DateFormat('yyyy-MM-dd – kk:mm').format(date_time);
  // }

  Design_News(context,String articles){
    // print(articles);
    var jsonResponse = convert.jsonDecode(articles);
    var Articles = jsonResponse['articles'];

    List<Widget> News_tiles = [];

    Articles.forEach((element) {
      News_tiles.add(
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              // border: Border.all(color: Color.fromARGB(15, 0, 0, 0),width: 2),
              border: Border.all(color: Color.fromARGB(17, 0, 0, 0),width: 2),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(9),
              child: Column(
                children: [
                  element["urlToImage"] != null ?
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    child:Container(
                      // padding: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color.fromARGB(24, 0, 0, 0),style: BorderStyle.solid,width: 2))
                      ),
                      child: Image.network(
                        element["urlToImage"],
                        // height: 200,
                        // width: 350,
                        fit: BoxFit.fitWidth,
                        loadingBuilder: (context,child,loadingProgress) {
                          return loadingProgress == null ? child : Center(child: CircularProgressIndicator(color: primaryColor,));
                        },
                      ),
                    )
                  )
                      :
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    child: Container(
                        height: 200,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border(bottom: BorderSide(color: Color.fromARGB(10, 0, 0, 0),style: BorderStyle.solid,width: 2))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.image_not_supported_outlined),
                            Text("No Image Found..."),],
                        )
                    ),
                  ),

                  ListTile(contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                    title: Text(
                      element['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(154, 0, 0, 0),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Published At : ",
                              textAlign: TextAlign.end,
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black38),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy , kk:mm a').format(DateTime.parse(element['publishedAt'])).split(",")[0],
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.black38),
                            ),
                          ],
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy , kk:mm a').format(DateTime.parse(element['publishedAt'])).split(",")[1],
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.black38),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => WebViewPage(url: element['url']),)
                );
              },
            ),
          )
      );
      News_tiles.add(
          // Divider(thickness: 2,height: 25,)
        SizedBox(height: 25,)
      );
    });

    return News_tiles;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchnews(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: primaryColor,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: Design_News(context,snapshot.data.toString())
              )
            // )
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(color: primaryColor,),
          );
        }
      },
    );
  }
}


class WebViewPage extends StatefulWidget {

  String? url;

  WebViewPage({Key? key, @required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcolor();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        backgroundColor: primaryColor,
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}