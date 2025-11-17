import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class CharachtersApi {
  late Dio dio;
  CharachtersApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharachters() async {
    try {
      Response response = await dio.get("character");

      return response.data["results"];
    } catch (e) {
      return [];
    }
  }
}
