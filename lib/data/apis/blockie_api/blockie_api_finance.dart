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
      final parameters = {'number': amount};
      final response = await _dio.post(url, queryParameters: parameters);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final cart = Cart.fromJson(object);
      return cart;
    } catch (error) {
      return null;
    }
  }

  Future<WechatPayParameters?> submitOrder(String id) async {
    try {
      final url = _urlBuilder.buildSubmitOrderUrl(id);
      final response = await _dio.post(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final parameters = WechatPayParameters.fromJson(object);
      return parameters;
    } catch (error) {
      return null;
    }
  }

  Future<PaginatedOrders?> getOrders({
    required int pageIndex,
    String? subactivityId,
  }) async {
    try {
      final url = _urlBuilder.buildGetOrdersUrl();
      final parameters = {'per_page': 10, 'page': pageIndex};
      final response = await _dio.get(url, queryParameters: parameters);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final orders = PaginatedOrders.fromJson(object);
      return orders;
    } catch (error) {
      return null;
    }
  }
}
