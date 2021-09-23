abstract class IApiProvider {
  Future<dynamic> get(String url, {Map<String, dynamic>? params});

  Future<dynamic> post(String url, dynamic data,
      {Map<String, dynamic>? params});
}
