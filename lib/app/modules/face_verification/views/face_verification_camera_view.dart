import 'dart:io';

import 'package:blockie_app/widgets/message_toast.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
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
  String? path;

  Future<void> _initCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        return;
      }
      _controller = CameraController(_cameras[0], ResolutionPreset.max);
      MessageToast.showMessage('InitCamera');
      _controller?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((error) {
        if (error is CameraException) {
          switch (error.code) {
            case 'CameraAccessDenied':
              print('User denied camera access.');
              break;
            default:
              print('Handle other errors.');
              break;
          }
        }
      });
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
    if (_controller == null) {
      return Container();
    }
    if (!_controller!.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Column(
        children: [
          CameraPreview(_controller!),
          Image.file(
            File(path ?? ""),
            width: 200,
            height: 200,
          ),
          GestureDetector(
            child: const Text('Take 3'),
            onTap: () async {
              MessageToast.showMessage('Take Photo');
              try {
                final image = await _controller!.takePicture();
                path = image.path;
                setState(() {});
                MessageToast.showMessage("Image: $path");
              } catch (e) {
                MessageToast.showMessage("Error: ${e.toString()}");
              }
            },
          ),
        ],
      ),
    );
  }
}
