// Package imports:
import 'package:city_pickers/city_pickers.dart';

// Project imports:
import 'package:blockie_app/services/local_assets_service.dart';

class CityPickersUtils {
  static const abroadKey = "999999";

  static Map<String, String> get provinces =>
      {...CityPickers.metaProvinces, abroadKey: "海外"};

  static Map<String, dynamic> get cities {
    final maps = LocalAssetsService.to.countries
        .map((it) => {
              '${it.code}': {'name': it.name, 'alpha': it.alpha}
            })
        .toList();
    final countryMap = maps.isNotEmpty
        ? maps.reduce((value, element) => {...value, ...element})
        : {};
    final abroadCities = {abroadKey: countryMap};
    return {...CityPickers.metaCities, ...abroadCities};
  }

  static String? getRegion(String code) {
    if (code.isEmpty) {
      return null;
    }
    final util = CityPickerUtil(provincesData: provinces, citiesData: cities);
    final result = util.getAreaResultByCode(code);
    var region = '';
    if (result.provinceName != null && result.provinceId != abroadKey) {
      region += result.provinceName!;
    }
    if (result.cityName != null) {
      if (region.isNotEmpty) {
        region += ' ';
      }
      region += result.cityName!;
    }
    if (result.areaName != null) {
      if (region.isNotEmpty) {
        region += ' ';
      }
      region += result.areaName!;
    }
    return region;
  }
}
