import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../localdata.dart';
import '../../models/base/base_model.dart';
import '../../util.dart';
import 'http_client.dart';

mixin PostHelper {
  Future<http.Response> httpPost(String urlPath, Object? body) async {
    var uri = Uri.https(baseUrl, urlPath);
    checkRequest(uri, body);

    try {
      var response = await http.post(uri, body: body, headers: {
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

  Future<http.Response> httpPostAuth(String urlPath, Object? body) async {
    var uri = Uri.http(baseUrl, urlPath);
    checkRequest(uri, body);

    var response = await HttpClient().client.post(uri, body: body, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await LocalData.getToken()}',
    });

    checkResponse(response);

    return response;
  }

  void checkRequest(Uri uri, Object? body) {
    Debug.log(
        '------------------------ post request body ------------------------------------------------');
    Debug.log(uri);
    if (body is String) {
      Debug.formattedJson(body);
    }
  }

  void checkResponse(http.Response response) {
    Debug.log(
        '------------------------ response ------------------------------------------------');
    if (response.statusCode == 200) {
      Debug.formattedJson(response.body);
    } else {
      Debug.log(response.statusCode);
      Debug.formattedJson(response.body);
      Debug.showErrorMessage(status: response.statusCode, body: response.body);
    }
  }
}
