part 'settings_item_group.dart';

part 'settings_item.dart';

class SettingsItemGroups {
  final List<SettingsItemGroup> groups;

  SettingsItemGroups({
    required this.groups,
  });

  static List<SettingsItemGroup> initial(String phoneNumber, String version) {
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
          SettingsItem(title: '用户条款'),
          SettingsItem(title: '隐私政策'),
        ],
      ),
    ];
  }
}
