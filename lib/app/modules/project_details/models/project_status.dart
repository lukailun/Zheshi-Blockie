enum ProjectStatus {
  unknown(0, "未知", 0xFFFFFFFF),
  notStarted(1, "活动未开始", 0x80FFFFFF),
  ongoing(2, "活动进行中", 0xFF07DFAB),
  expired(3, "活动已结束", 0xFFFFFFFF);

  const ProjectStatus(this.value, this.description, this.colorValue);

  final int value;
  final String description;
  final int colorValue;
}
