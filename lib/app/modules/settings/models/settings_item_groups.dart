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
    required String phoneNumber,
    required String version,
    required VoidCallback termsOfServiceOnTap,
    required VoidCallback privacyPolicyOnTap,
  }) {
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
        items: [
          SettingsItem(title: '当前版本', content: version, arrowIsVisible: false),
          SettingsItem(title: '用户条款', onTap: termsOfServiceOnTap),
          SettingsItem(title: '隐私政策', onTap: privacyPolicyOnTap),
        ],
      ),
    ];
  }
}
