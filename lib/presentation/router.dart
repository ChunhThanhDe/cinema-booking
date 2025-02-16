/*
 * @ Author: Chung Nguyen Thanh <chunhthanhde.dev@gmail.com>
 * @ Created: 2024-12-17 21:30:56
 * @ Message: 🎯 Happy coding and Have a nice day! 🌤️
 */

// ignore_for_file: constant_identifier_names
import 'package:cinema_booking/common/helpers/log_helpers.dart';
import 'package:cinema_booking/domain/entities/movies/movies.dart';
import 'package:cinema_booking/domain/entities/response/home.dart';
import 'package:cinema_booking/presentation/booking/book_time_slot/sc_book_time_slot.dart';
import 'package:cinema_booking/presentation/home/home_main.dart';
import 'package:cinema_booking/presentation/login/pages/login.dart';
import 'package:cinema_booking/presentation/login/pages/register.dart';
import 'package:cinema_booking/presentation/movie/movie_detail_info.dart';
import 'package:cinema_booking/presentation/splash/splash.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String HOME = '/';
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String MOVIE = '/movie';
  static const String BOOK_TIME_SLOT = '/bookTimeSlot';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashPage());

      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case REGISTER:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case BOOK_TIME_SLOT:
        var movie = settings.arguments as MovieEntity;
        LogHelper.logDebug(tag: "AppRouter", message: "BOOK_TIME_SLOT Done " + movie.toString());
        return MaterialPageRoute(builder: (_) => BookTimeSlotScreen(movie: movie));

      case MOVIE:
        var movieDetail = settings.arguments as MovieDetailEntity;
        return MaterialPageRoute(builder: (_) => MovieInfoScreen(movie: movieDetail));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
