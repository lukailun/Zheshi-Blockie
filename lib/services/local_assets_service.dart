// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/reverse_address/country.dart';

class LocalAssetsService extends GetxService {
  static LocalAssetsService get to => Get.find();
  List<Country> countries = [];

  @override
  void onReady() async {
    super.onReady();
    final jsonString =
        await rootBundle.loadString('assets/json_files/countries.json');
    countries = (jsonDecode(jsonString) as List)
        .map((it) => Country.fromJson(it))
        .where((it) => !it.isChina)
        .toList();
  }
}
