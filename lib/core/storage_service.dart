import 'package:firebase_storage/firebase_storage.dart';
import 'package:universal_html/html.dart' as html;
import 'package:younghappychallenge/core/result.dart';

class StorageService {
  final FirebaseStorage _storage;

  StorageService(this._storage);

  Future<Result<String>> uploadProfileFromWebImage(
    html.File file,
    String uid,
  ) async {
    final Reference ref = _storage.ref('users/$uid/profile.jpeg');
    try {
      final TaskSnapshot taskSnapshot = await ref.putBlob(file);
      final String imageUri = await taskSnapshot.ref.getDownloadURL();
      return Success(imageUri);
    } catch (e) {
      return Failure(e.message);
    }
  }

  Future<Result<String>> uploadProfileFromMobileImage(
    String path,
    String uid,
  ) async {
    final Reference ref = _storage.ref('users/$uid/profile.jpeg');
    try {
      final UploadTask uploadTask = ref.putString(path);
      final String imageUri = await uploadTask.snapshot.ref.getDownloadURL();
      return Success(imageUri);
    } catch (e) {
      return Failure(e.message);
    }
  }
}
