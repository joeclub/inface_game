import 'package:http/http.dart' as http;

import 'http_client.dart';
import '../../constants.dart';
import '../../localdata.dart';
import '../../models/base/base_model.dart';
import '../../util.dart';

mixin GetHelper {
  Future<http.Response> httpGet(String urlPath,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var url = Uri.https(baseUrl, urlPath, queryParameters);

      checkUri(url);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      checkResponse(response);
      return response;
    } catch (error) {
      BaseModel baseModel = BaseModel(msg: error.toString(), result: 0);
      String json = baseModelToJson(baseModel);
      return http.Response(json, 408);
    }
  }

  Future<http.Response> httpGetAuth(String urlPath,
      {Map<String, dynamic>? queryParameters}) async {
    var url = Uri.http(baseUrl, urlPath, queryParameters);

    checkUri(url);

    var response = await HttpClient().client.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await LocalData.getToken()}',
    });

    checkResponse(response);

    return response;
  }

  void checkUri(Uri uri) {
    Debug.log(
        '------------------------ get request uri ------------------------------------------------');
    Debug.log(uri);
  }

  void checkResponse(http.Response response) {
    Debug.log(
        '------------------------ response ------------------------------------------------');
    if (response.statusCode == 200) {
      Debug.formattedJson(response.body);
    } else {
      Debug.log('statusCode ${response.statusCode}');
      Debug.formattedJson(response.body);
      //Debug.showErrorMessage(status: response.statusCode, body: response.body);
    }
  }
}
