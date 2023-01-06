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

  Future<Cart?> updateCart(String id, int amount) async {
    try {
      final url = _urlBuilder.buildUpdateCartUrl(id);
      final requestData = {'number': amount};
      final response = await _dio.post(url, data: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final cart = Cart.fromJson(object);
      return cart;
    } catch (error) {
      return null;
    }
  }
}
