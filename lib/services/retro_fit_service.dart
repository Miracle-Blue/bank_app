import 'package:bank_app/models/card_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart' as http;

part 'retro_fit_service.g.dart';

bool isTester = true;

const String SERVER_DEVELOPMENT = "https://6209f31f92946600171c5604.mockapi.io";
const  String SERVER_PRODUCTION = "https://6209f31f92946600171c5604.mockapi.io";

// *** CLIENT *** //
@RestApi(baseUrl: SERVER_DEVELOPMENT)
abstract class RetroFitNetwork {
  factory RetroFitNetwork(Dio dio, {String baseUrl}) = _RetroFitNetwork;

  static const Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  // !===== GET ===== //
  @GET("/api/v1/cards")
  Future<List<CCard>> getCards();

  // !Get using @Path
  @GET("/api/v1/cards/{id}")
  Future<CCard> getCardWithId(@Path("id") String id);

  // !===== POST ===== //
  @POST("/api/v1/cards")
  @http.Headers(headers)
  Future<CCard> createCard(@Body() CCard card);

  // // !===== PUT / PATCH ===== //  @PUT("/api/v1/notes/{id}")
  // @http.Headers(headers)
  // Future<Card> updateNote(@Path() String id, @Body() Card card);

  // !===== DELETE ===== //
  @DELETE("/api/v1/cards/{id}")
  @http.Headers(headers)
  Future<void> deleteCard(@Path("id") String id);
}