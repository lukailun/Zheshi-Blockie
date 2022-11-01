// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/blockie_app.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/services/wechat_service/wechat_service.dart';

void main() async {
  await dotenv.load(fileName: 'env/development.env');
  WidgetsFlutterBinding.ensureInitialized();
  _initServices();
  runApp(const BlockieApp());
}

void _initServices() {
  Get.put(AuthService());
  Get.put(AnyWebService());
  Get.put(WechatService());
}
