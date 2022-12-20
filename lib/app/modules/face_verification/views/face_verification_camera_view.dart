// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:camera/camera.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/widgets/message_toast.dart';

class FaceVerificationCameraView extends StatefulWidget {
  final void Function(XFile) onPhotoTaken;

  const FaceVerificationCameraView({
    Key? key,
    required this.onPhotoTaken,
  }) : super(key: key);

  @override
  State<FaceVerificationCameraView> createState() =>
      FaceVerificationCameraViewState();
}

class FaceVerificationCameraViewState
    extends State<FaceVerificationCameraView> {
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  Future<void> _initCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        return;
      }
      _controller = CameraController(_cameras[0], ResolutionPreset.medium);
      if (_controller != null) {
        _initializeControllerFuture = _controller!.initialize();
        setState(() {});
      }
    } catch (error) {
      MessageToast.showMessage(error.toString());
    }
  }

  void takePhoto() async {
    XFile? file = await _controller?.takePicture();
    if (file != null) {
      widget.onPhotoTaken(file);
    }
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: min(256, Get.width - 120),
      height: min(256, Get.width - 120),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(min(256, Get.width - 120) / 2),
        child: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                _controller != null) {
              return CameraPreview(_controller!);
            } else {
              return Container(color: Colors.white);
            }
          },
        ),
      ),
    );
  }
}
