import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/models/data_response.dart';
import 'package:magic_notes/services/user_services.dart';

import '../models/user.dart';

class UserRepository {
  UserServices userServices;

  UserRepository({
    required this.userServices,
  });

  Future<DataResponse?> logIn(User user) async {
    var response = await userServices.logIn(user);
    return response;
  }

  Future<DataResponse?> signUp(User user) async {
    var response = await userServices.signUp(user);
    return response;
  }

  Future<DataResponse?> getUserInfo(String userId) async {
    var response = await userServices.getUserInfo(userId);
    return response;
  }

  Future<DataResponse?> changeUserInfo(String userId, String userName, String userDescription) async {
    var response = await userServices.changeUserInfo(userId, userName, userDescription);
    return response;
  }

  Future<DataResponse?> changeUserPassword(String userEmail, String password, String confirmPassword) async {
    var response = await userServices.changeUserPassword(userEmail, password, confirmPassword);
    return response;
  }

  Future<DataResponse?> forgotUserPassword(String userEmail) async {
    var response = await userServices.forgotUserPassword(userEmail);
    return response;
  }

  Future<DataResponse?> getUserPhoto(String userId) async{
    var response = await userServices.getUserPhoto(userId);
    return response;
  }

  Future<DataResponse?> changeUserPhoto(String userId, String base64) async{
    var response = await userServices.changeUserPhoto(userId, base64);
    return response;
  }
}

final userRepositoryPr = Provider<UserRepository>(
  (ref) {
    final userServices = ref.read(userServicesPr);
    return UserRepository(userServices: userServices);
  },
);
