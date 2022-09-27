import 'dart:html';

class AllowedUriPolicy implements UriPolicy {
  @override
  bool allowsUri(String uri) {
    return true;
  }
}
