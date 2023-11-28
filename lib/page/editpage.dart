import 'package:fl_cruddemo/page/listpage.dart';
import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../services/firebase_crud.dart';

class EditPage extends StatefulWidget {
  final Ukm? ukm;
  EditPage({this.ukm});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  final _ukm_nama = TextEditingController();
  final _ukm_nim = TextEditingController();
  final _ukm_jurusan = TextEditingController();
  final _ukm_fakultas = TextEditingController();
  final _ukm_minatukm = TextEditingController();
  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _docid.value = TextEditingValue(text: widget.ukm!.uid.toString());
    _ukm_nama.value = TextEditingValue(text: widget.ukm!.nama.toString());
    _ukm_nim.value = TextEditingValue(text: widget.ukm!.nim.toString());
    _ukm_jurusan.value = TextEditingValue(text: widget.ukm!.jurusan.toString());
    _ukm_fakultas.value =
        TextEditingValue(text: widget.ukm!.fakultas.toString());
    _ukm_minatukm.value =
        TextEditingValue(text: widget.ukm!.minatukm.toString());
  }

  @override
  Widget build(BuildContext context) {
    final DocIDField = TextField(
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final namaField = TextFormField(
        controller: _ukm_nama,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nama",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final nimField = TextFormField(
        controller: _ukm_nim,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "nim",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final jurusanField = TextFormField(
        controller: _ukm_jurusan,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "kelas",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final fakultasField = TextFormField(
        controller: _ukm_fakultas,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "hobi",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final minatukmField = TextFormField(
        controller: _ukm_minatukm,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "kelas",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text('View List of Employee'));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrud.updateukm(
                name: _ukm_nama.text,
                nim: _ukm_nim.text,
                jurusan: _ukm_jurusan.text,
                fakultas: _ukm_fakultas.text,
                minatukm: _ukm_minatukm.text,
                docId: _docid.text);
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Update",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Unit Kegiatan Mahasiswa'),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DocIDField,
                  const SizedBox(height: 25.0),
                  namaField,
                  const SizedBox(height: 25.0),
                  nimField,
                  const SizedBox(height: 35.0),
                  jurusanField,
                  const SizedBox(height: 35.0),
                  fakultasField,
                  const SizedBox(height: 35.0),
                  minatukmField,
                  viewListbutton,
                  const SizedBox(height: 45.0),
                  SaveButon,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
