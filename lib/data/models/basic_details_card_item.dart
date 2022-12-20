class BasicDetailsCardItem {
  final String title;
  final String content;
  final bool ellipsized;
  final bool copyable;
  final String? iconUrl;

  const BasicDetailsCardItem({
    required this.title,
    required this.content,
    this.ellipsized = false,
    this.copyable = false,
    this.iconUrl,
  });
}
