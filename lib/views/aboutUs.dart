import 'package:app_practica/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';


class AboutUsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Us View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'About Us Viewe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: Row(
              children: [
              IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp())), 
                icon: Icon(Icons.arrow_back),
              ),
              Text("Acerca de WCAG"),
              ],
            ),
          )
        ],
        //title: Text(),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
        ),
        
          child: SizedBox(
            width: 300,
            height: 130,
            child:   Card(
            color:  Colors.green,
            shadowColor: Colors.blueGrey,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.accessibility,
                    size: 40,
                  ),
                  title: Text(
                    "WCAG es una app que te explicará sobre las normativas para que desarrolles apps geniales"
                  ),
                )
              ],
            ),
          ),
      ) ,
      ),
    );
  }
}
