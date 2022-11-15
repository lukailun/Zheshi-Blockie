enum ShareType {
  info(id: infoId, title: '作品信息'),
  image(id: imageId, title: '高清原图'),
  poster(id: posterId, title: '分享海报'),
  video(id: videoId, title: '视频下载');

  const ShareType({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  static const infoId = 'info';
  static const imageId = 'image';
  static const posterId = 'poster';
  static const videoId = 'video';
}
