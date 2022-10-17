part of 'settings_item_groups.dart';

class SettingsItem {
  final String title;
  final String? content;
  final bool arrowIsVisible;
  final VoidCallback? onTap;

  SettingsItem({
    required this.title,
    this.content,
    this.arrowIsVisible = true,
    this.onTap,
  });
}
