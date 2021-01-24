import 'dart:typed_data';

import 'package:universal_html/html.dart' as html;

abstract class ProfileImageModel {}

class ProfileMobileImageModel implements ProfileImageModel {
  final String path;

  const ProfileMobileImageModel(this.path);
}

class ProfileWebImageModel implements ProfileImageModel {
  final html.File file;
  final Uint8List data;

  const ProfileWebImageModel(this.file, this.data);
}
