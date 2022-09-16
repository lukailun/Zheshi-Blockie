import 'package:blockie_app/widgets/message_toast.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

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

  Future<void> _initCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
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
      MessageToast.showMessage(e.toString());
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
        home: Column(
      children: [
        SizedBox(
          height: 300,
          child: CameraPreview(controller!),
        ),
        ElevatedButton(
          onPressed: () {
            MessageToast.showMessage('Take Photo');
            try {
              controller!.takePicture().then(
                  (value) => {MessageToast.showMessage("Success: $value")});
            } catch (e) {
              MessageToast.showMessage(e.toString());
            }
          },
          child: const Text(
            'Take Photo',
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    ));
  }
}
