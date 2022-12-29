part of 'blockie_api.dart';

extension BlockieApiFinance on BlockieApi {
  Future<Cart?> getCart(String id) async {
    try {
      final url = _urlBuilder.buildGetCartUrl(id);
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final cart = Cart.fromJson(object);
      return cart;
    } catch (error) {
      return null;
    }
  }
}