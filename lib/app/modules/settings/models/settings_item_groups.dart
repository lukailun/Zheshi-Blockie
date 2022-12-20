// Dart imports:
import 'dart:ui';

// Project imports:
import 'package:blockie_app/data/models/environment.dart';

// Project imports:

part 'settings_item_group.dart';

part 'settings_item.dart';

class SettingsItemGroups {
  final List<SettingsItemGroup> groups;

  SettingsItemGroups({
    required this.groups,
  });

  static List<SettingsItemGroup> initial({
    required bool isStaff,
    required String phoneNumber,
    required String version,
    required Function() termsOfServiceOnTap,
    required Function() privacyPolicyOnTap,
    required Function() activitiesManagementOnTap,
    required Function() developerModeOnTap,
  }) {
    final aboutUsItems = [
      SettingsItem(title: '当前版本', content: version, arrowIsVisible: false),
      SettingsItem(title: '用户条款', onTap: termsOfServiceOnTap),
      SettingsItem(title: '隐私政策', onTap: privacyPolicyOnTap),
    ];
    if (isStaff) {
      aboutUsItems
          .add(SettingsItem(title: '活动管理', onTap: activitiesManagementOnTap));
    }
    if (Environment.isDevelopment) {
      aboutUsItems.add(SettingsItem(title: '开发者模式', onTap: developerModeOnTap));
    }
    return [
      SettingsItemGroup(
        title: '账号安全',
        items: [
          SettingsItem(
              title: '手机绑定', content: phoneNumber, arrowIsVisible: false),
        ],
      ),
      SettingsItemGroup(
        title: '关于我们',
        items: aboutUsItems,
      ),
    ];
  }
}
