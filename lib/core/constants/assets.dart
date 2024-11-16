import 'package:http/http.dart' as http_client;

import '../enums/http_method.dart';

const baseUrl = 'localhost:3000';

class HttpClientHelper {
  const HttpClientHelper();

  Future<http_client.Response> request({
    required String endpoint,
    required HttpMethod method,
    Map<String, dynamic>? queryParameters,
  }) async {
    final url = Uri.https(
      baseUrl,
      endpoint,
      queryParameters,
    );
    final headers = {'Content-Type': 'application/json'};
    final request = await _httpMethod(url, headers, method);

    return request;
  }

  Future<http_client.Response> _httpMethod(
    Uri url,
    Map<String, String> headers,
    HttpMethod method,
  ) {
    switch (method) {
      case HttpMethod.post:
        return http_client.post(url, headers: headers);
      case HttpMethod.get:
        return http_client.get(url, headers: headers);
      case HttpMethod.put:
        return http_client.put(url, headers: headers);
      case HttpMethod.delete:
        return http_client.delete(url, headers: headers);
      default:
        return http_client.get(url, headers: headers);
    }
  }
}
