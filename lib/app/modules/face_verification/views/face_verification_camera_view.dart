import 'dart:math';
import 'dart:typed_data';
import 'package:get/get.dart';
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
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  Uint8List? bytes;

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
              return const SizedBox();
            }
          },
        ),
      ),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(min(256, Get.width - 120) / 2),
      child: SizedBox(
        width: min(256, Get.width - 120),
        height: min(256, Get.width - 120),
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    _controller != null) {
                  return CameraPreview(_controller!);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
