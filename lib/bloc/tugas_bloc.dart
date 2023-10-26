import 'dart:convert';
import 'package:paket_b2/helpers/api.dart';
import 'package:paket_b2/helpers/api_url.dart';
import 'package:paket_b2/models/tugas.dart';

class TugasBloc {
  static Future<List<Tugas>> getTugas() async {
    String apiUrl = ApiUrl.listTugas;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listTugas_tmp = (jsonObj as Map<String, dynamic>)['result'];
    print(listTugas_tmp);
    List<Tugas> listTugas = [];
    for (int i = 0; i < listTugas_tmp.length; i++) {
      listTugas.add(Tugas.fromJson(listTugas_tmp[i]));
    }
    return listTugas;
  }

  static Future<bool> updateTugas({required Tugas tugas}) async {
    String apiUrl = ApiUrl.updateTugas(tugas.id!);
    var body = {
      "title": tugas.judul,
      "description": tugas.deskripsi,
      "deadline": tugas.deadline
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return (jsonObj['message'] == 'Assignment updated') ? true : false;
  }
}
