// Project imports:
import 'package:blockie_app/models/global.dart';

extension StringExtension on String {
  String get formatted => replaceAll("\\n", "\n");

  String get hostAdded => isNotEmpty ? "${Global.assetHost}$this" : this;
}
