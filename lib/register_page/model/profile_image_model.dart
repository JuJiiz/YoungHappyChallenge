import 'dart:typed_data';

abstract class ProfileImageModel {}

class ProfileMobileImageModel implements ProfileImageModel {
  final String path;

  const ProfileMobileImageModel(this.path);
}

class ProfileWebImageModel implements ProfileImageModel {
  final Uint8List data;

  const ProfileWebImageModel(this.data);
}
