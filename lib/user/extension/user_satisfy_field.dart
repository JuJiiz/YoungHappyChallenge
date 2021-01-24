import 'package:younghappychallenge/user/model/user_entity.dart';

extension UserChecker on UserEntity {
  bool isUserSatisfied() {
    final bool isDisplayNameSatisfy =
        displayName != null && displayName.isNotEmpty;
    return isDisplayNameSatisfy;
  }
}
