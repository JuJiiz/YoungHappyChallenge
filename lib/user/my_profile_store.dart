import 'package:flutter/material.dart';
import 'package:younghappychallenge/user/model/response_my_profile.dart';

class MyProfileProvider with ChangeNotifier {
  MyProfileProvider({
    this.myProfile,
  });

  ResponseMyProfile myProfile;

  updateMyProfile(ResponseMyProfile updated) {
    myProfile = updated;
    notifyListeners();
  }
}
