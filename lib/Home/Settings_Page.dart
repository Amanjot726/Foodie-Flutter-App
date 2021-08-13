import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{

  int? Country;

  var colors = [Colors.blue,Colors.orange,Colors.pink,Colors.deepPurple,Colors.green,Colors.black54];


  Color primaryColor=Colors.green;

  Future getcolor() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idx = prefs.getInt('color');
    print("color index = ${idx}");
    primaryColor = idx.runtimeType!=int?Colors.green:colors[idx!];
    setState(() {});
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
    setState(() {});
  }

  Future SetCountry({int idx=9}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('country');
    await prefs.setInt('country', idx);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcolor();
    getCountry();
  }


  var index = 1;


  var navigation_List = [
    "/home",
    "/settings"
  ];

  var countries={'Argentina' : 'ar', 'Australia' : 'au', 'Brazil' : 'br', 'Canada' : 'ca', 'China' : 'cn', 'France' : 'fr', 'Germany' : 'de', 'Hong Kong' : 'hk', 'India' : 'in', 'Israel' : 'il', 'Italy' : 'it', 'Japan' : 'jp', 'Malaysia' : 'my', 'Netherlands' : 'nl', 'New Zealand' : 'nz', 'Nigeria' : 'ng', 'Philippines' : 'ph', 'Russia' : 'ru', 'Saudi Arabia' : 'sa', 'Serbia' : 'rs', 'Singapore' : 'sg', 'South Africa' : 'za', 'South Korea' : 'kr', 'Switzerland' : 'ch', 'Taiwan' : 'tw', 'Thailand' : 'th', 'Turkey' : 'tr', 'United Kingdom' : 'gb', 'United States' : 'us',};

  Dropdown_items(){
    int i = 0;
    var widgets = <DropdownMenuItem<int>>[];
    countries.forEach((key, value) {
      i+=1;
      widgets.add(
        DropdownMenuItem(
          child: Text(" "+key),
          value: i,
        )
      );
    });
    return widgets;
  }


  Colors_widgets(){
    var widgets = <Widget>[];

    colors.forEach((element) {
      widgets.add(
        InkWell(
          borderRadius: BorderRadius.circular(100),
          child: Column(
            children: [
              Container(
                  width: 30,
                  height: 30,
                  child:Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white60,width: 3),
                      color: element,
                    ),
                  )
              )
            ],
          ),
          onTap: (){
            setState(() {
              SetColor(idx:colors.indexOf(element));
              primaryColor = element;
            });
          },
        )
      );
      colors.indexOf(element)<colors.length-1 ? widgets.add(SizedBox(width: 25,)) :"";
    });
  return widgets;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(
              color: Color.fromARGB(185, 0, 0, 0),
              fontFamily: 'AlfaSlabOne',
              letterSpacing: 1.4
            ),
          ),
          backgroundColor: primaryColor,
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                value!=index?Navigator.pushReplacementNamed(context, navigation_List[value as int]):"";
              },
              icon: Icon(Icons.more_vert,color: Color.fromARGB(185, 0, 0, 0),),
              itemBuilder: (context)=>[
                PopupMenuItem(
                  child: Text("Home"),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: 1,
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 231, 231, 231),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: "Home"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: "Settings"
              ),

            ],
            currentIndex: index,
            selectedFontSize: 12,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            selectedItemColor: primaryColor,
            onTap: (idx) { // idx will have value of the index of BottomNavBarItem
              setState(() {
                index!=idx ? Navigator.pushReplacementNamed(context, navigation_List[idx]) :
                index = idx;
                // Navigato
              });
            }
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Change Theme",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Righteous',
                      color: Color.fromARGB(171, 0, 0, 0)
                    ),
                  )
                ],
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: Colors_widgets()
              ),
              SizedBox(height: 40,),
              Divider(thickness: 0.7,),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Change Country",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Righteous',
                      color: Color.fromARGB(171, 0, 0, 0)
                    ),
                  )
                ],
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // DropdownButtonFormField(items: items)
                  Container(
                    width: 170,
                    height: 52,
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: primaryColor,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor,
                          blurRadius: 2.5,
                          spreadRadius: 0.1,
                        ),
                      ]
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          focusColor: primaryColor,
                          value: Country,
                          items: Dropdown_items(),
                          style:TextStyle(color: Color.fromARGB(176, 0, 0, 0), fontSize: 17.5),
                          icon: Icon(Icons.arrow_drop_down_circle,color: primaryColor,),
                          // iconSize: 26,
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              Country = value as int;
                              SetCountry(idx:value);
                            });
                          }
                      ),
                    )
                  )
                ],
              ),
              SizedBox(height: 40,),
              Divider(thickness: 0.7,),
              SizedBox(height: 295,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: new Container(
                      margin: const EdgeInsets.only(left: 25.0, right: 8.0),
                      child: Divider(
                        color: Colors.black26,
                      )
                    ),
                  ),
                  Text("Developer : ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black38),),
                  Text("Amanjot Singh",style: TextStyle(color: Colors.black38),),
                  Expanded(
                    child: new Container(
                      margin: const EdgeInsets.only(left: 8.0, right: 25.0),
                      child: Divider(
                        color: Colors.black26,
                      )
                    ),
                  ),
                ],
              ),
            ],
          )
        )
    );
  }
}

