import 'package:app_practica/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';


class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Searching',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
        actions: <Widget>[
          Container(
            child: IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp() )), 
                icon: Icon(Icons.arrow_back),
              ),
          ),
          Text("Busca libre"),
        ],
      ),

      body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
            left: 40.0,
            right: 30.0,
            top: 30.0,
          ),    
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.0),
            color: Colors.white,
          ),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                CupertinoIcons.search_circle,
                size: 40.0, 
              ),
              hintText: "Palabras clave o de interés",
            ),
          ),
        ),
      );
  }
}
