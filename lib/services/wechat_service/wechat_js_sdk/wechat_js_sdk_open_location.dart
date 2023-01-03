part of wechat_js_sdk;

@JS('wx.openLocation')
external Object wechatOpenLocation(WechatOpenLocationParams params);

@JS()
@anonymous
class WechatOpenLocationParams {
  external double get latitude;

  external double get longitude;

  external String get name;

  external String get address;

  external int get scale;

  external String get infoUrl;

  external factory WechatOpenLocationParams({
    double latitude,
    double longitude,
    String name,
    String address,
    int scale,
    String infoUrl,
  });
}
