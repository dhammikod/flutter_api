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

  static Future<List<CostResult>> getCosts(
      var origin, var destination, var weight, var courier) async {
    print('kerequest for cicak');
    // final queryParameters = {
    //   'province': provID,
    // };
    var response = await http.post(
      Uri.https('api.rajaongkir.com', '/starter/cost'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      },
      body: jsonEncode(<String, String>{
        'origin': origin,
        'destination': destination,
        'weight': weight,
        'courier': courier,
      }),
    );

    // print(response);
    var job = json.decode(response.body);
    // print(job);
    // print(job['rajaongkir']);
    List<CostResult> result = [];

    if (response.statusCode == 200) {
      result = (job['rajaongkir']['results'] as List)
          .map((e) => CostResult.fromMap(e))
          .toList();
    }
    // print(result);
    // print('ngeretun');
    // print(result[0].costs![0].cost![0].etd);
    // print(result[0]);
    return result;
  }
}
// CostResult(
//   jne, Jalur Nugraha Ekakurir (JNE), 
//   [
//     Cost(OKE, Ongkos Kirim Ekonomis, [Instance of 'CostInfo']), 
//     Cost(REG, Layanan Reguler, [Instance of 'CostInfo']), 
//     Cost(YES, Yakin Esok Sampai, [Instance of 'CostInfo'])
//     ]
//   )
