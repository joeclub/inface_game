import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../localdata.dart';

class HttpClient {
  static final HttpClient _singleton = HttpClient._internal();

  factory HttpClient() {
    return _singleton;
  }

  HttpClient._internal() {
    _client = RetryClient(
      http.Client(),
      retries: 1,
      when: (response) {
        return response.statusCode == 401;
      },
      onRetry: (req, res, retryCount) async {
        if (retryCount == 0 && res?.statusCode == 401) {
          // refresh token
          // 재로그인
          //ReissueTokenService reissueTokenService = ReissueTokenService();
          //await reissueTokenService.reissue();
          req.headers['Authorization'] = 'Bearer ${await LocalData.getToken()}';
        }
      },
    );
  }

  late RetryClient _client;

  RetryClient get client => _client;
}
