// Dart imports:
import 'dart:ui';

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
