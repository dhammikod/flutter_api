part of 'services.dart';

class MasterDataService {
  static Future<List<Province>> getProvince() async {
    var response = await http.get(
        Uri.parse(Const.baseUrl + '/starter/province'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'key': Const.apiKey,
        });

    var job = json.decode(response.body);
    List<Province> result = [];

    if (response.statusCode == 200) {
      result = (job['rajaongkir']['results'] as List)
          .map((e) => Province.fromJson(e))
          .toList();
    }
    return result;
  }

  // static Future<List<City>> getCities(var provID) async {
  //   var response = await http.get(Uri.parse(Const.baseUrl + '/starter/city'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'key': Const.apiKey,
  //       });

  //   var job = json.decode(response.body);
  //   List<City> result = [];

  //   if (response.statusCode == 200) {
  //     result = (job['rajaongkir']['results'] as List)
  //         .map((e) => City.fromJson(e))
  //         .toList();
  //   }

  //   List<City> selectedcities = [];
  //   for (var c in result) {
  //     if (c.provinceId == provID) {
  //       selectedcities.add(c);
  //     }
  //   }
  //   return selectedcities;
  // }

  static Future<List<City>> getCitybyprovince(var provID) async {
    print('kerequest');
    final queryParameters = {
      'province': provID,
    };
    var response = await http.get(
        Uri.https('api.rajaongkir.com', '/starter/city', queryParameters),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'key': Const.apiKey,
        });

    var job = json.decode(response.body);
    List<City> result = [];

    if (response.statusCode == 200) {
      result = (job['rajaongkir']['results'] as List)
          .map((e) => City.fromMap(e))
          .toList();
    }

    return result;
  }
}
