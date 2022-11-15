class ShareInfoItem {
  final String id;
  final String title;
  final String imageUrl;
  final String? linkUrl;

  ShareInfoItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.linkUrl,
  });
}