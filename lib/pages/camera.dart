import 'package:blockie_app/widgets/message_toast.dart';
import 'package:camera/camera.dart';
import 'package:camera_web/camera_web.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

late List<CameraDescription> _cameras;

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? controller;

  Future<html.MediaStream?> _openCamera() async {
    final html.MediaStream? stream = await html.window.navigator.mediaDevices
        ?.getUserMedia({'video': true, 'audio': true});
    // _preview.srcObject = stream;
    MessageToast.showMessage('Camera: ' + stream.toString());
    return stream;
  }

  Future<void> _initCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      // await _openCamera();
      _cameras = await availableCameras();
      controller = CameraController(_cameras[0], ResolutionPreset.max);
      controller?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              print('User denied camera access.');
              break;
            default:
              print('Handle other errors.');
              break;
          }
        }
      });
    } catch (e) {
      // MessageToast.showMessage(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Container();
    }
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller!),
    );
  }
}
