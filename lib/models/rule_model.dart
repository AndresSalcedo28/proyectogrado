import 'package:cloud_firestore/cloud_firestore.dart';

class RuleModel {
  static const String collectionName = 'reglas';

  static const String _nombre = 'nombre';
  static const String _descripcion = 'descripcion';

  static final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection(RuleModel.collectionName);

  final DocumentReference? reference;
  final String nombre;
  final String descripcion;

  RuleModel({required this.nombre, required this.descripcion, this.reference});

  RuleModel.fromMap(Map<String, dynamic>? map, this.reference)
      : assert(map?[_nombre] != null),
        assert(map?[_descripcion] != null),
        this.nombre = map?[_nombre],
        this.descripcion = map?[_descripcion];

  RuleModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap)
      : this.fromMap(snap.data(), snap.reference);

  static List<RuleModel> listFromSnapshot(
          List<DocumentSnapshot<Map<String, dynamic>>> snaps) =>
      snaps.map((snap) => new RuleModel.fromSnapshot(snap)).toList();

  static Future<List<RuleModel>> fetchAll() async => RuleModel.listFromSnapshot(
      (await RuleModel._collectionReference.get()).docs);
}
