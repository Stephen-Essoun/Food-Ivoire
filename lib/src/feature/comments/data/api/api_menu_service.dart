import 'dart:convert';
import 'dart:developer';

import 'package:foodivoire/src/feature/Vendors/domain/entities/vendor_model.dart';
import 'package:foodivoire/src/shared/constant/base_url.dart';
import 'package:foodivoire/src/shared/errors/exception.dart';
import 'package:foodivoire/src/shared/interceptor/http.client.interceptor.dart';

class MenuCommentApiService {
 
  Future<Comment> customerMenuComment (String comment, int menuId) async {
    const url = '$baseUrl/customers/comment/menu';
    try {
      final response = await client.post(
        url,
        body: {
          "comment": comment,
          "menuId": '$menuId',
        },
      );
      log(response.body.toString());
      if (response.statusCode != 200) {
        var errorMessage = json.decode(response.body)['errors'];

        throw CustomException(errorMessage['menuId'] + errorMessage['comment'] ??
            'Comment failed. Try again');
      }
    return Comment.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

 
}
