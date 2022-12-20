enum SubactivityStatus {
  unknown(0, "未知", 0xFFFFFFFF),
  notStarted(1, "未开始", 0x80FFFFFF),
  ongoing(2, "进行中", 0xFF07DFAB),
  expired(3, "已结束", 0xFFFFFFFF);

  const SubactivityStatus(this.value, this.description, this.colorValue);

  final int value;
  final String description;
  final int colorValue;
}
