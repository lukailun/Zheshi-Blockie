// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/date.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';

part 'update_birthday_controller_router.dart';

class UpdateBirthdayController extends GetxController {
  final AccountRepository accountRepository;

  UpdateBirthdayController({
    required this.accountRepository,
  });

  final selectedBirthday = Rxn<Date>();

  bool saveButtonIsEnabled() {
    return selectedBirthday.value != null &&
        AuthService.to.userInfo.value?.birthday != selectedBirthday.value;
  }

  @override
  void onReady() {
    super.onReady();
    selectedBirthday.value = AuthService.to.userInfo.value?.birthday;
  }

  void updateBirthday() async {
    final birthday = selectedBirthday.value;
    if (birthday == null) {
      return;
    }
    final userInfo =
        await accountRepository.updateBirthday(birthday.toJsonString);
    if (userInfo == null) {
      return;
    }
    AuthService.to.updateUserInfo(callback: () {
      selectedBirthday.value = AuthService.to.userInfo.value?.birthday;
      MessageToast.showMessage('修改成功');
    });
  }

  void birthdayOnTap(BuildContext context) {
    final now = DateTime.now();
    DatePicker.showDatePicker(
      context,
      currentTime: selectedBirthday.value != null
          ? DateTime(
              selectedBirthday.value!.year,
              selectedBirthday.value!.month,
              selectedBirthday.value!.day,
            )
          : DateTime(now.year - 18, now.month, now.day),
      minTime: DateTime(now.year - 100, now.month, now.day),
      maxTime: now,
      locale: LocaleType.zh,
      theme: const DatePickerTheme(
        cancelStyle: TextStyle(
          color: AppThemeData.primaryColor,
          fontSize: 16,
          fontWeight: FontWeightCompat.regular,
        ),
        doneStyle: TextStyle(
          color: AppThemeData.primaryColor,
          fontSize: 16,
          fontWeight: FontWeightCompat.regular,
        ),
        itemStyle: TextStyle(color: AppThemeData.primaryColor, fontSize: 18),
      ),
      onConfirm: (dateTime) {
        selectedBirthday.value = Date(
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
        );
      },
    );
  }
}
