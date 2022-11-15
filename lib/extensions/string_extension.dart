// Project imports:
import 'package:blockie_app/models/global.dart';

extension StringExtension on String {
  String get formatted => replaceAll("\\n", "\n");

  String get hostAdded => isNotEmpty ? "${Global.assetHost}$this" : this;

  bool parseBool() {
    if (toLowerCase() == 'true') {
      return true;
    }
    if (toLowerCase() == 'false') {
      return false;
    }
    throw '"$this" can not be parsed to boolean.';
  }
}
