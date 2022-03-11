// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retro_fit_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RetroFitNetwork implements RetroFitNetwork {
  _RetroFitNetwork(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://6209f31f92946600171c5604.mockapi.io';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<CCard>> getCards() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<CCard>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/api/v1/cards',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => CCard.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<CCard> getCardWithId(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CCard>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/cards/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CCard.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CCard> createCard(card) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(card.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CCard>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/json; charset=UTF-8')
            .compose(_dio.options, '/api/v1/cards',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CCard.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> deleteCard(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    await _dio.fetch<void>(_setStreamType<void>(Options(
            method: 'DELETE',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json; charset=UTF-8')
        .compose(_dio.options, '/api/v1/cards/${id}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
