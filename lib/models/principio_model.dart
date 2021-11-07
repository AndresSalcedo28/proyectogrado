import 'package:accesi/models/lineamiento_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PrincipioModel {
  static const String collectionName = 'principios';

  static const String _nombre = 'nombre';
  static const String _definicion = 'definicion';

  static final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection(PrincipioModel.collectionName);

  List<LineamientoModel> _lineamientos = [];

  final DocumentReference reference;
  final String nombre;
  final String definicion;

  PrincipioModel(
      {required this.nombre,
      required this.definicion,
      required this.reference});

  PrincipioModel.fromMap(Map<String, dynamic>? map, this.reference)
      : assert(map?[_nombre] != null),
        assert(map?[_definicion] != null),
        this.nombre = map?[_nombre],
        this.definicion = map?[_definicion];

  Future<List<LineamientoModel>> lineamientos() async {
    if (_lineamientos.length == 0) {
      await this.fetchLineamientos();
    }

    return _lineamientos;
  }

  PrincipioModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap)
      : this.fromMap(snap.data(), snap.reference);

  static List<PrincipioModel> listFromSnapshot(
          List<DocumentSnapshot<Map<String, dynamic>>> snaps) =>
      snaps.map((snap) => new PrincipioModel.fromSnapshot(snap)).toList();

  static Future<List<PrincipioModel>> fetchAll() async =>
      PrincipioModel.listFromSnapshot(
          (await PrincipioModel._collectionReference.get()).docs);

  Future<void> fetchLineamientos() async {
    print("Referencia: " + this.reference.toString());
    this._lineamientos =
        await LineamientoModel.fetchLineamientoByPrincipio(this.reference);
  }
}
