/*
 * @ Author: Chung Nguyen Thanh <chunhthanhde.dev@gmail.com>
 * @ Created: 2024-12-21 21:31:49
 * @ Message: 🎯 Happy coding and Have a nice day! 🌤️
 */

import 'package:cinema_booking/domain/entities/cinema/cinema.dart';
import 'package:cinema_booking/domain/entities/genres/genres.dart';
import 'package:cinema_booking/domain/entities/movies/banner.dart';
import 'package:cinema_booking/domain/entities/movies/movies.dart';

part 'movie_by_genres.dart';

class HomeEntity {
  List<BannerEntity> banners;
  List<GenresEntity> genres;
  List<MovieEntity> recommendedMovies;
  List<CinemaEntity> nearbyCinemas;
  List<MovieByGenresEntity> movieByGenres;

  HomeEntity({
    required this.banners,
    required this.genres,
    required this.recommendedMovies,
    required this.nearbyCinemas,
    required this.movieByGenres,
  });
}
