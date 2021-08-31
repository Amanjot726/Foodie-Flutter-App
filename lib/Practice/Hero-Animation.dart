import 'package:flutter/material.dart';


class HeroPageOne extends StatelessWidget {
  const HeroPageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero Page One"),
      ),
      body: Center(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HeroPageTwo(),));
          },
          child: Hero(
            tag: "my-tag",
            child: Image.network("https://images.unsplash.com/photo-1630003092701-654f5236eedf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",height: 100,width: 100,),
          ),
        ),
      ),
    );
  }
}


class HeroPageTwo extends StatelessWidget {
  const HeroPageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero Page Two"),
      ),
      body: Center(
        child: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Hero(
            tag: "my-tag",
            child: Image.network("https://images.unsplash.com/photo-1630003092701-654f5236eedf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",height: 100,width: 100,),
          ),
        ),
      ),
    );
  }
}
