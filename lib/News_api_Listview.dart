import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

Future<String> fetchnews() async{
  String apikey = '24c5a60e9a924705938d1cac2101590f';
  String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey="+apikey;

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body;
  }
  else {
    return 'Request failed with status: ${response.statusCode}';
  }
}

class NewsPage extends StatelessWidget {

  Design_News(context,String articles){
    print(articles);
    var jsonResponse = convert.jsonDecode(articles);
    var Articles = jsonResponse['articles'];

    List<Widget> News_tiles = [];

    Articles.forEach((element) {
        News_tiles.add(
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              border: Border.all(color: Color.fromARGB(15, 0, 0, 0),width: 2),
            ),
            child: InkWell(
              child: Column(
                children: [
                  element["urlToImage"] != null ?
                  ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      child:Image.network(
                        element["urlToImage"],
                        height: 200,
                        width: 350,
                        fit: BoxFit.fill,
                        loadingBuilder: (context,child,loadingProgress) {
                          return loadingProgress == null ? child : Center(child: CircularProgressIndicator());
                        },
                      )
                  )
                      :
                  ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  child: Container(
                      height: 200,
                      width: 350,
                      color: Colors.black12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported_outlined),
                          Text("No Image Found..."),],
                      )
                    ),
                  ),

                  ListTile(
                    title: Text(element['title']),
                    subtitle: Text(element['publishedAt'],textAlign: TextAlign.end,),

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
            Divider()
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
          return ListView(
            padding: EdgeInsets.all(20),
            children: Design_News(context,snapshot.data.toString())
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
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        backgroundColor: Colors.green,
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}