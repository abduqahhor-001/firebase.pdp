import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StoreService {
  static final _storage = FirebaseStorage.instance.ref();
  static final folder = "post_images";

  static Future<String> uploadImage(File _image) async {
    String imgName = 'image_${DateTime.now().millisecondsSinceEpoch}';
    var firebaseStorageRef = _storage.child(folder).child(imgName);
    var uploadTask = firebaseStorageRef.putFile(_image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final String downloadUrl = await firebaseStorageRef.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }
}
