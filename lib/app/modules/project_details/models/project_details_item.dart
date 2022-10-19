class ProjectDetailsItem {
  final String title;
  final String content;
  final bool ellipsized;
  final bool copyable;

  const ProjectDetailsItem({
    required this.title,
    required this.content,
    this.ellipsized = false,
    this.copyable = false,
  });
}
