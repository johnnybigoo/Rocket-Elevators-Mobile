import 'package:rocket_elevators/app/core/properties.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  final _properties = Get.find<Properties>();

  Future<bool> authentication(String email) {
    return
      http
          .get(Uri.parse("${_properties.employee_endp}/$email"))
          .then((response) {
              return response.body == "true" ? true : false;
          })
          .catchError((onError) => throw onError);
  }
}