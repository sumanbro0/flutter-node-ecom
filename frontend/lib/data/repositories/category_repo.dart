import 'package:dio/dio.dart';
import 'package:frontend/core/api.dart';
import 'package:frontend/data/models/category/category_model.dart';

class CategoryRepo {
  final _api = Api();
  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      Response response = await _api.sendRequest.get(
        '/category',
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
