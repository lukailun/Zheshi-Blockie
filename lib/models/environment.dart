// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get environment => dotenv.env['ENVIRONMENT'] ?? '';

  static String get appTitle => dotenv.env['APP_TITLE'] ?? '';

  static String get blockieUrl => dotenv.env['BLOCKIE_URL'] ?? '';

  static String get anyWebUrl => dotenv.env['ANY_WEB_URL'] ?? '';

  static String get serverHost => dotenv.env['SERVER_HOST'] ?? '';
}
