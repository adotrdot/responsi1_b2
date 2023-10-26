import 'package:flutter/material.dart';
import 'package:paket_b2/models/tugas.dart';
import 'package:paket_b2/ui/tugas_form.dart';

class TugasDetail extends StatefulWidget {
  Tugas? tugas;

  TugasDetail({Key? key, this.tugas}) : super(key: key);

  @override
  _TugasDetailState createState() => _TugasDetailState();
}

class _TugasDetailState extends State<TugasDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tugas'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Judul : ${widget.tugas!.judul}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Deadline : ${widget.tugas!.deadline}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Deskripsi : ${widget.tugas!.deskripsi}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TugasForm(
                            tugas: widget.tugas!,
                          )));
            }),
      ],
    );
  }
}
