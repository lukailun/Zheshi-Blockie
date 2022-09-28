import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class FaceVerificationController extends GetxController {
  final AccountRepository repository;
  final bytes = Rxn<Uint8List>();
  FaceVerificationController({required this.repository});

  void uploadFacePhoto() {
    repository.uploadFacePhoto().then((isSuccessful) {

    });
  }
}
