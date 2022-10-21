enum ProjectStatus {
  unknown(0, "未知"),
  notStarted(1, "活动未开始"),
  ongoing(2, "活动进行中"),
  expired(3, "活动已结束");

  const ProjectStatus(this.value, this.description);

  final int value;
  final String description;
}