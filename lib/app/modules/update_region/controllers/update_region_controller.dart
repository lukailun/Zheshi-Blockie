// Dart imports:
import 'dart:js' as js;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:city_pickers/city_pickers.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/region.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/common_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';
import 'package:blockie_app/utils/city_pickers_utils.dart';
import 'package:blockie_app/widgets/message_toast.dart';

part 'update_region_controller_router.dart';

class UpdateRegionController extends GetxController {
  final AccountRepository accountRepository;
  final CommonRepository commonRepository;

  UpdateRegionController({
    required this.accountRepository,
    required this.commonRepository,
  });

  final locationRegion = Rxn<Region>();
  final selectedRegion = Rxn<Region>();

  bool saveButtonIsEnabled() {
    final code = selectedRegion.value?.code ?? locationRegion.value?.code;
    return code != null && AuthService.to.userInfo.value?.region?.code != code;
  }

  @override
  void onReady() {
    super.onReady();
    selectedRegion.value = AuthService.to.userInfo.value?.region;
  }

  void locationRegionOnTap() {
    if (locationRegion.value != null) {
      return;
    }
    wechatGetLocation(
      WechatGetLocationParams(
        type: 'wgs84',
        success: js.allowInterop(
          (result) {
            final latitude = result.latitude;
            final longitude = result.longitude;
            if (latitude == null || longitude == null) {
              return;
            }
            reverseAddressLookup(latitude: latitude, longitude: longitude);
          },
        ),
      ),
    );
  }

  void regionOnTap(BuildContext context) async {
    final result = await CityPickers.showCityPicker(
      context: context,
      provincesData: CityPickersUtils.provinces,
      citiesData: CityPickersUtils.cities,
      locationCode: selectedRegion.value?.code ?? '110000',
      confirmWidget: const Text('确定')
          .textColor(AppThemeData.primaryColor)
          .fontSize(16)
          .fontWeight(FontWeightCompat.regular),
      cancelWidget: const Text('取消')
          .textColor(AppThemeData.primaryColor)
          .fontSize(16)
          .fontWeight(FontWeightCompat.regular),
    );
    final areaCode =
        (result?.areaId ?? 'null') != 'null' ? result?.areaId : null;
    final cityCode =
        (result?.cityId ?? 'null') != 'null' ? result?.cityId : null;
    final provinceCode =
        (result?.provinceId ?? 'null') != 'null' ? result?.provinceId : null;
    final code = areaCode ?? cityCode ?? provinceCode;
    if (code == null) {
      return;
    }
    final isChina = (provinceCode ?? '') != CityPickersUtils.abroadKey;
    selectedRegion.value = Region(
      isChina: isChina,
      areaCode: isChina ? code : '',
      countryCode: isChina ? '' : code,
    );
  }

  void reverseAddressLookup({
    required String latitude,
    required String longitude,
  }) async {
    final reverseAddress =
        await commonRepository.reverseAddressLookup(latitude, longitude);
    if (reverseAddress == null) {
      return;
    }
    final areaCode = reverseAddress.administrativeDivisionInfo.areaCode ?? '';
    final countryCode = reverseAddress.administrativeDivisionInfo.countryCode;
    final isChina = reverseAddress.isChina;
    locationRegion.value = Region(
      isChina: isChina,
      areaCode: isChina ? areaCode : '',
      countryCode: isChina ? '' : countryCode,
    );
    selectedRegion.value = locationRegion.value;
  }

  void updateRegion() async {
    final region = selectedRegion.value;
    if (region == null) {
      return;
    }
    final userInfo = await accountRepository.updateRegion(region.toJsonString);
    if (userInfo == null) {
      return;
    }
    AuthService.to.updateUserInfo(callback: () async {
      selectedRegion.value = AuthService.to.userInfo.value?.region;
      MessageToast.showMessage('修改成功');
    });
  }
}
