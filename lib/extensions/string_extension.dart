// Package imports:
import 'package:city_pickers/city_pickers.dart';

// Project imports:
import 'package:blockie_app/data/apis/blockie_api/blockie_url_builder.dart';

extension StringExtension on String {
  String get formatted => replaceAll("\\n", "\n");

  String get hostAdded =>
      isNotEmpty ? "${BlockieUrlBuilder.resourceHost}/$this" : this;

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
