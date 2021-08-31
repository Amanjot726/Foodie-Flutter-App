import 'package:flutter/material.dart';

Route getAnimatedRoute(Widget page){
  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) {
      return page;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<Offset>(
        begin: Offset(0.0, 1.0),
        end: Offset.zero
      );
      var curveTween = CurveTween(curve: Curves.bounceIn);

      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );
}

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page One"),
      ),
      body: Center(
        child: TextButton(
          child: Text("Go to Page Two"),
          onPressed: (){
            Navigator.of(context).push(getAnimatedRoute(PageTwo()));
          },
        ),
      ),
    );
  }
}


class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Two"),
      ),
      body: Center(
        child: Text("Welcome to Page Two"),
      ),
    );
  }
}
