import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/models/data_response.dart';
import 'package:magic_notes/models/user.dart';
import 'package:magic_notes/repository/user_repository.dart';

class UserNotifier extends ChangeNotifier {
  late UserRepository userRepository;
  bool isLoading = false;
  DataResponse? dataResponse;
  String? logInResult = "";
  String? signUpResult = "";
  String? changePasswordResult = "";
  User? userInfo;

  UserNotifier({required this.userRepository});

  //Xử lí logIn
  Future<DataResponse?> logIn(User user) async {
    isLoading = true;
    notifyListeners();
    dataResponse = await userRepository.logIn(user);
    logInResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    return dataResponse;
  }

  //Xử lí logIn
  Future<DataResponse?> sigUp(User user) async {
    isLoading = true;
    notifyListeners();
    dataResponse = await userRepository.signUp(user);
    signUpResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    return dataResponse;
  }

  // Lấy thông tin người dùng
  getUserInfo(String userId) async {
    dataResponse = await userRepository.getUserInfo(userId);
    userInfo = User.fromJson(dataResponse!.data);
    notifyListeners();
  }

  //Đổi thông tin người dùng
  Future<DataResponse?> changeUserInfo(String userEmail, String userName, String userDescription) async {
    isLoading = true;
    notifyListeners();
    dataResponse = await userRepository.changeUserInfo(userEmail, userName, userDescription);
    isLoading = false;
    notifyListeners();
    //print(dataResponse);
    return dataResponse;
  }

  //Đổi mật khẩu
  Future<DataResponse?> changeUserPassword(String userEmail, String password, String confirmPassword) async {
    isLoading = true;
    notifyListeners();
    dataResponse = await userRepository.changeUserPassword(userEmail, password, confirmPassword);
    //changePasswordResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    //print(dataResponse);
    return dataResponse;
  }

  //Reset mật khẩu
  Future<DataResponse?> forgotUserPassword(String userEmail) async {
    isLoading = true;
    notifyListeners();
    dataResponse = await userRepository.forgotUserPassword(userEmail);
    //changePasswordResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    //print(dataResponse);
    return dataResponse;
  }
}

final userProvider = ChangeNotifierProvider((ref) {
  UserRepository userRepository = ref.watch(userRepositoryPr);
  return UserNotifier(userRepository: userRepository);
});
