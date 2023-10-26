class ApiUrl {
  static const String baseUrl = 'https://responsi1b.dalhaqq.xyz/api';
  static const String listTugas = baseUrl + '/assignments';
  static String updateTugas(int id) {
    return baseUrl + '/assignments/' + id.toString() + '/update';
  }

  static String showProduk(int id) {
    return baseUrl + '/assignments/' + id.toString();
  }
}
