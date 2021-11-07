import 'package:accesi/models/lineamiento_model.dart';
import 'package:accesi/models/principio_model.dart';
import 'package:flutter/material.dart';
import 'package:blurry/blurry.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewLineamientos extends StatefulWidget {
  final PrincipioModel principio;

  ViewLineamientos({required this.principio});

  @override
  _ViewLineamientosState createState() => _ViewLineamientosState();
}

class _ViewLineamientosState extends State<ViewLineamientos> {
  bool _loading = true;
  bool _fetch = true;
  List<LineamientoModel> _lineamientos = [];

  Future<void> _fetchLineamientos({bool state:true}) async {
    final fetchedLineamientos = await widget.principio.lineamientos();

    setState(() {
      _lineamientos = fetchedLineamientos;
      _loading = false;
      _fetch = false;
    });
  }

  Widget _groupsCard(LineamientoModel groups) {
    return Card(
        child: Column(children: [
      ListTile(
        leading: Icon(
          FontAwesomeIcons.list,
          size: 35,
        ),
        title: Text(
          groups.nombre,
        ),
        subtitle: Text("Definición: ${groups.definicion}"),
        onTap: () {
          Blurry.info(
              title: groups.nombre,
              description: groups.definicion,
              confirmButtonText: 'Ver mas...',
              onConfirmButtonPressed: () => {
                print("HolaMundo")
              }).show(context);
        },
      )
    ]));
  }

  Widget _groupList() {
    return Container(
      child: Column(children: _lineamientos.map(_groupsCard).toList()),
    );
  }

  Future<void> _refreshGroups({bool state: true}) async {
    final fetchedGroups = await LineamientoModel.fetchAll();
    setState(() {
      _lineamientos = fetchedGroups;
      _loading = false;
      _fetch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_fetch) {
      _refreshGroups(state: false);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Lineamientos"),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                Center(
                  child: Text("Accesibilidad WCAG es una app que te explicará sobre las normativas para que desarrolles apps geniales"),
                )
              ])),
            ),
          ),
          _loading ? LinearProgressIndicator() : _groupList(),
        ],
      ),
    );
  }
}