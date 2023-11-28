import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('ukm');

class FirebaseCrud {
// Menambahkan dokumen Mahasiswa baru ke koleksi Firestore
  static Future<Response> addukm({
    required String name,
    required String fakultas,
    required String nim,
    required String jurusan,
    required String minatukm,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();
    // Data yang akan ditambahkan ke Firestore
    Map<String, dynamic> data = <String, dynamic>{
      "nama": name,
      "jurusan": jurusan,
      "nim": nim,
      "fakultas": fakultas,
      "minatukm": minatukm
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> updateukm({
    required String name,
    required String jurusan,
    required String nim,
    required String fakultas,
    required String minatukm,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "nama": name,
      "hobi": jurusan,
      "nim": nim,
      "kelas": fakultas,
      "cita-cita": minatukm
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Berhasil updated Data Mahasiswa";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readukm() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> deleteukm({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Berhasil Menghapus Data Mahasiswa";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
