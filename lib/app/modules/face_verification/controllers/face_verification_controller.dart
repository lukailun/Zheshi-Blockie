import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class FaceVerificationController extends GetxController {
  final AccountRepository repository;
  FaceVerificationController({required this.repository});

  void uploadFacePhoto(List<int> bytes, String filename) {
    repository.uploadFacePhoto(bytes, filename).then((isSuccessful) {});
  }
}
