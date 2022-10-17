// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:get/get.dart';

extension GetNavigation on GetInterface {
  static const _parameterName = 'p';

  Map<String, dynamic> get jsonParameters {
    final jsonString = Get.parameters[_parameterName] as String;
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return json;
  }

  String jsonString(Map<String, dynamic> parameters) {
    return '$_parameterName=${jsonEncode(parameters)}';
  }

  Future<T?>? toNamedWithJsonParameters<T>(
    String page, {
    Map<String, dynamic>? parameters,
    int? id,
    bool preventDuplicates = true,
  }) {
    final newPage = (parameters ?? {}).isNotEmpty
        ? '$page?${Get.jsonString(parameters ?? {})}'
        : page;
    return Get.toNamed(newPage);
  }
}
