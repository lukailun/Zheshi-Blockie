import 'dart:html';

class AnchorUtils {
  static void call({
    required String phoneNumber,
  }) {
    final anchorElement = AnchorElement(href: 'tel:$phoneNumber');
    anchorElement.click();
  }

  static void download({
    required String url,
    required String fileName,
  }) {
    final anchorElement = AnchorElement(href: url);
    anchorElement.download = fileName;
    anchorElement.click();
  }
}
