class Tugas {
  int? id;
  String? judul;
  String? deskripsi;
  String? deadline;

  Tugas({this.id, this.judul, this.deskripsi, this.deadline});

  factory Tugas.fromJson(Map<String, dynamic> obj) {
    return Tugas(
        id: obj['id'],
        judul: obj['title'],
        deskripsi: obj['description'],
        deadline: obj['deadline']);
  }
}
