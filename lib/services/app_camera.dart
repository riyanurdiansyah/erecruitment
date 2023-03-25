import 'dart:io';

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class AppCameraService {
  Future<CameraController> getCameraController(
      ResolutionPreset resolutionPreset,
      CameraLensDirection cameraLensDirection) async {
    final cameras = await availableCameras();

    return CameraController(cameras[0], resolutionPreset, enableAudio: false);
  }

  Future<String?> findLocalPath() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    } else if (Platform.isIOS) {
      externalStorageDirPath = (await getApplicationDocumentsDirectory()).path;
    }
    return externalStorageDirPath;
  }
}
