import 'package:younghappychallenge/register_page/model/input_user_register.dart';

extension RegisterChecker on InputUserRegister {
  RegisterCheck isSatisfied() {
    bool isDisplayNamePass = false;
    bool isNationalityPass = false;
    bool isGenderPass = false;
    bool isBirthDatePass = false;

    if (displayName != null && displayName.isNotEmpty) isDisplayNamePass = true;
    if (country != null) isNationalityPass = true;
    if (gender != null) isGenderPass = true;
    if (birthDate != null) isBirthDatePass = true;

    if (!isDisplayNamePass) {
      return RegisterCheck.DisplayName;
    } else if (!isNationalityPass) {
      return RegisterCheck.Nationality;
    } else if (!isGenderPass) {
      return RegisterCheck.Gender;
    } else if (!isBirthDatePass) {
      return RegisterCheck.BirthDate;
    } else {
      return RegisterCheck.Pass;
    }
  }
}

enum RegisterCheck { DisplayName, Nationality, Gender, BirthDate, Pass }
