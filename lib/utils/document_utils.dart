import 'dart:html' as html;

class DocumentElement {
  final String tagName;
  final String? innerText;
  final Map<String, dynamic>? attributes;

  DocumentElement({
    required this.tagName,
    this.innerText,
    this.attributes,
  });
}

class DocumentUtils {
  static void appendChildInHead(DocumentElement documentElement) {
    final element = _getElement(documentElement);
    html.document.querySelector('head')?.append(element);
  }

  static void appendChildInBody(DocumentElement documentElement) {
    final element = _getElement(documentElement);
    html.document.querySelector('body')?.append(element);
  }

  static html.Element _getElement(DocumentElement documentElement) {
    final element = html.document.createElement(documentElement.tagName);
    final innerText = documentElement.innerText;
    if (innerText != null) {
      element.innerText = innerText;
    }
    final attributes = documentElement.attributes;
    if (attributes != null) {
      attributes.forEach((key, value) {
        element.setAttribute(key, value);
      });
    }
    return element;
  }
}
