// Project imports:
import 'package:blockie_app/data/models/video.dart';

class ShareInfoItem {
  final String id;
  final String title;
  final String imageUrl;
  final Video? video;

  ShareInfoItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.video,
  });
}
