import 'package:Rocket_Elevators/app/modules/login/login_repo.dart';
import 'package:get/instance_manager.dart';

class LoginService {
  final repo = Get.find<LoginRepo>();

  Future<bool> authentication(String email) {
    return repo.authentication(email).then((bool) => bool);
  }
}