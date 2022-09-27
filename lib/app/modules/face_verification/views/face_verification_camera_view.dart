import 'dart:typed_data';

import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FaceVerificationCameraView extends StatefulWidget {
  const FaceVerificationCameraView({Key? key}) : super(key: key);

  @override
  State<FaceVerificationCameraView> createState() =>
      _FaceVerificationCameraViewState();
}

class _FaceVerificationCameraViewState
    extends State<FaceVerificationCameraView> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  Uint8List? bytes;

  Future<void> _initCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        return;
      }
      _controller = CameraController(_cameras[0], ResolutionPreset.medium);
      _initializeControllerFuture = _controller.initialize();
    } catch (error) {
      MessageToast.showMessage(error.toString());
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
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_controller);
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}
