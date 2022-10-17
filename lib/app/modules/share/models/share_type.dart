enum ShareType {
  info(ID: 0, title: '作品信息'),
  image(ID: 1, title: '高清原图'),
  poster(ID: 1, title: '分享海报');

  const ShareType({
    required this.ID,
    required this.title,
  });

  final int ID;
  final String title;
}
