import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blurry/blurry.dart';
import 'package:blurry/resources/arrays.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:accesi/pages/view_lineamientos.dart';

import 'package:accesi/models/principio_model.dart';
import 'package:accesi/views/about_us.dart';
import 'package:accesi/views/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accesi',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Accesi'),
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
  bool _loading = true;
  bool _fetch = true;
  bool _dialVisible = true;
  List<PrincipioModel> _groups = [];
  List<String> roomNames = List<String>.empty();

  Future<void> _refreshGroups({bool state: true}) async {
    final fetchedGroups = await PrincipioModel.fetchAll();
    setState(() {
      _groups = fetchedGroups;
      _loading = false;
      _fetch = false;
    });
  }

  Widget _groupsCard(PrincipioModel groups) {
    return Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
            child: Column(children: [
              Icon(
                FontAwesomeIcons.list,
                size: 30,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                groups.nombre,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15),
              )
            ]),
            //subtitle: Text("Definición: ${groups.definicion}"),
            onTap: () {
              Blurry.info(
                      title: groups.nombre,
                      description: groups.definicion,
                      confirmButtonText: 'Ver mas...',
                      onConfirmButtonPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewLineamientos(principio: groups))))
                  .show(context);
            },
          )
        ])));
  }

  Widget _groupList() {
    return Container(
      child: Column(children: _groups.map(_groupsCard).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_fetch) {
      _refreshGroups(state: false);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                          "Accesibilidad WCAG es una app que te explicará sobre las normativas para que desarrolles apps geniales"),
                    ))
                  ])),
            ),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      children: _groups.map(_groupsCard).toList())))
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        visible: _dialVisible,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        //onOpen: () => print('OPENING DIAL'),
        //onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.search_sharp),
              backgroundColor: Colors.green,
              label: 'Buscar',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchView()))),
          SpeedDialChild(
              child: Icon(Icons.info_outline_rounded),
              backgroundColor: Colors.blue,
              label: 'Acerca de',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsView()))
              //onTap: () => print('SECOND CHILD'),
              ),
          SpeedDialChild(
            child: Icon(Icons.exit_to_app),
            backgroundColor: Colors.red,
            label: 'Salir App',

            //onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }
}
