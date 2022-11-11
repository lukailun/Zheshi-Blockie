enum ShareType {
  info(ID: 0, title: '作品信息'),
  image(ID: 1, title: '高清原图'),
  poster(ID: 2, title: '分享海报'),
  video(ID: 3, title: '视频下载');

  const ShareType({
    required this.ID,
    required this.title,
  });

  final int ID;
  final String title;
}
