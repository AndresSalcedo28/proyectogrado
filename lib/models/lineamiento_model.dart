import 'package:accesi/models/criterio_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LineamientoModel {
  static const String collectionName = 'lineamientos';

  static const String _nombre = 'nombre';
  static const String _definicion = 'definicion';
  static const String _principio = 'principio';

  static final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection(LineamientoModel.collectionName);

  List<CriterioModel> _criterios = [];

  final DocumentReference reference;
  final String nombre;
  final String definicion;

  LineamientoModel(
      {required this.nombre,
      required this.definicion,
      required this.reference});

  LineamientoModel.fromMap(Map<String, dynamic>? map, this.reference)
      : assert(map?[_nombre] != null),
        //assert(map?[_definicion] != null),
        this.nombre = map?[_nombre],
        this.definicion =
            map != null && map[_definicion] != null ? map[_definicion] : '';

  LineamientoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap)
      : this.fromMap(snap.data(), snap.reference);

  static Future<List<LineamientoModel>> fetchLineamientoByPrincipio(
      DocumentReference principioReference) async {
    final collection = await _collectionReference
        .where(_principio, isEqualTo: principioReference)
        .get();

    return LineamientoModel.listFromSnapshot(collection.docs);
  }

  Future<List<CriterioModel>> criterios() async {
    if (_criterios.length == 0) {
      await this.fetchCriterios();
    }

    return _criterios;
  }

  static List<LineamientoModel> listFromSnapshot(
          List<DocumentSnapshot<Map<String, dynamic>>> snaps) =>
      snaps.map((snap) => new LineamientoModel.fromSnapshot(snap)).toList();

  static Future<List<LineamientoModel>> fetchAll() async =>
      LineamientoModel.listFromSnapshot(
          (await LineamientoModel._collectionReference.get()).docs);

  Future<void> fetchCriterios() async {
    this._criterios =
        await CriterioModel.fetchCriterioByLineamiento(this.reference);
  }
}
