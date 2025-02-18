/*
 * @ Author: Chung Nguyen Thanh <chunhthanhde.dev@gmail.com>
 * @ Created: 2024-12-21 21:32:37
 * @ Message: 🎯 Happy coding and Have a nice day! 🌤️
 */

import 'package:cinema_booking/data/models/response/all_movie_by_type_response.dart';
import 'package:cinema_booking/data/models/response/booking_time_slot_by_cinema_response.dart';
import 'package:cinema_booking/data/models/response/home_response.dart';
import 'package:cinema_booking/data/models/response/list_seat_slot_by_seat_type_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://3bf0d4a6-7d3c-4091-b2dc-bcc085520363.mock.pstmn.io")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/homeData')
  Future<HomeModelResponse> getHomeData();

  @GET("/bookingTime")
  Future<List<BookingTimeSlotByCinemaResponse>> getBookingTimeSlotByCine();

  @GET("/bookSeat")
  Future<ListSeatModelResponse> getListSeatSlotBySeatType();

  @GET("/allMovie")
  Future<AllMoviesModelResponse> getAllMoviesByType();
}
