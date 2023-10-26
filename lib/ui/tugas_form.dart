import 'package:flutter/material.dart';
import 'package:paket_b2/bloc/tugas_bloc.dart';
import 'package:paket_b2/models/tugas.dart';
import 'package:paket_b2/ui/home.dart';
import 'package:paket_b2/widgets/warning_dialog.dart';

class TugasForm extends StatefulWidget {
  Tugas? tugas;

  TugasForm({Key? key, this.tugas}) : super(key: key);

  @override
  _TugasFormState createState() => _TugasFormState();
}

class _TugasFormState extends State<TugasForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _deadlineController = TextEditingController();

  @override
  void initState() {
    super.initState();

    isUpdate();
  }

  isUpdate() {
    if (widget.tugas != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _judulController.text = widget.tugas!.judul!;
        _deskripsiController.text = widget.tugas!.deskripsi!;
        _deadlineController.text = widget.tugas!.deadline!;
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _judulTugasField(),
                _deskripsiTugasField(),
                _deadlineTugasField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat text field judul tugas
  Widget _judulTugasField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Judul"),
      keyboardType: TextInputType.text,
      controller: _judulController,
      validator: (value) {
        if (value!.isEmpty) return "Judul harus diisi!";
        return null;
      },
    );
  }

  // Membuat text field deskripsi tugas
  Widget _deskripsiTugasField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deskripsi"),
      keyboardType: TextInputType.multiline,
      controller: _deskripsiController,
      validator: (value) {
        if (value!.isEmpty) return "Deskripsi harus diisi!";
        return null;
      },
    );
  }

  // Membuat text field deadline tugas
  Widget _deadlineTugasField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deadline"),
      keyboardType: TextInputType.datetime,
      controller: _deadlineController,
      validator: (value) {
        if (value!.isEmpty) return "Deadline harus diisi!";
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.tugas != null) {
                //kondisi update produk
                ubah();
              } else {
                //kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    print("Fitur simpan belum diimplementasikan T_T");
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Tugas updateTugas = Tugas(id: null);
    updateTugas.id = widget.tugas!.id;
    updateTugas.judul = _judulController.text;
    updateTugas.deskripsi = _deskripsiController.text;
    updateTugas.deadline = _deadlineController.text;
    TugasBloc.updateTugas(tugas: updateTugas).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const TugasPage(),
          ),
          (Route<dynamic> route) => false);
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
