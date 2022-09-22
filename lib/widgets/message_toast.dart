import 'package:fluttertoast/fluttertoast.dart';

class MessageToast{
  static void showMessage(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        webPosition: "center",
        webBgColor: "#666666",
        timeInSecForIosWeb: 2,
        fontSize: 16.0
    );
  }

  static void showException(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        webPosition: "center",
        webBgColor: "#ff0000",
        timeInSecForIosWeb: 2,
        fontSize: 16.0
    );
  }
}