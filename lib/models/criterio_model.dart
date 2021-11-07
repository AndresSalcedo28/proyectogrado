import 'package:cloud_firestore/cloud_firestore.dart';

class CriterioModel {
  static const String collectionName = 'criterio';

  static const String _nombre = 'nombre';
  static const String _definicion = 'definicion';
  static const String _lineamiento = 'lineamiento';

  static final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection(CriterioModel.collectionName);

  final DocumentReference reference;
  final String nombre;
  final String definicion;

  CriterioModel(
      {required this.nombre,
      required this.definicion,
      required this.reference});

  CriterioModel.fromMap(Map<String, dynamic>? map, this.reference)
      : assert(map?[_nombre] != null),
        //assert(map?[_definicion] != null),
        this.nombre = map?[_nombre],
        this.definicion =
            map != null && map[_definicion] != null ? map[_definicion] : '';

  CriterioModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap)
      : this.fromMap(snap.data(), snap.reference);

  static Future<List<CriterioModel>> fetchCriterioByLineamiento(
      DocumentReference lineamientoReference) async {
    final collection = await _collectionReference
        .where(_lineamiento, isEqualTo: lineamientoReference)
        .get();

    return CriterioModel.listFromSnapshot(collection.docs);
  }

  static List<CriterioModel> listFromSnapshot(
          List<DocumentSnapshot<Map<String, dynamic>>> snaps) =>
      snaps.map((snap) => new CriterioModel.fromSnapshot(snap)).toList();

  static Future<List<CriterioModel>> fetchAll() async =>
      CriterioModel.listFromSnapshot(
          (await CriterioModel._collectionReference.get()).docs);
}
