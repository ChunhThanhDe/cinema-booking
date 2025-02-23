import 'package:cinema_booking/data/models/response/movie_detail_response.dart';
import 'package:cinema_booking/domain/entities/response/all_mobie_by_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_movie_by_type_response.g.dart';

@JsonSerializable()
class AllMoviesModelResponse {
  @JsonKey(name: "now_showing")
  List<MovieDetailResponse> nowMovieing;

  @JsonKey(name: "coming_soon")
  List<MovieDetailResponse> comingSoon;

  @JsonKey(name: "exclusive")
  List<MovieDetailResponse> exclusive;

  AllMoviesModelResponse(this.nowMovieing, this.comingSoon, this.exclusive);

  factory AllMoviesModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AllMoviesModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllMoviesModelResponseToJson(this);

  @override
  String toString() {
    return 'AllMoviesByTypeResponse{nowMovieing: $nowMovieing, comingSoon: $comingSoon, exclusive: $exclusive}';
  }
}

extension AllMoviesModelResponseX on AllMoviesModelResponse {
  AllMoviesEntity toEntity() {
    return AllMoviesEntity(
      nowMovieing: nowMovieing.toEntities(),
      comingSoon: comingSoon.toEntities(),
      exclusive: exclusive.toEntities(),
    );
  }
}
