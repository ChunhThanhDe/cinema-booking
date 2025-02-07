/*
 * @ Author: Chung Nguyen Thanh <chunhthanhde.dev@gmail.com>
 * @ Created: 2024-12-22 08:26:40
 * @ Message: 🎯 Happy coding and Have a nice day! 🌤️
 */

import 'package:cinema_booking/domain/entities/genres/genres.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genres.g.dart';

@JsonSerializable()
class GenresModel {
  String? id;
  String? name;
  @JsonKey(name: "list_movie")
  List<String>? listMovie;

  GenresModel({
    this.id,
    this.name,
    this.listMovie,
  });

  factory GenresModel.fromJson(Map<String, dynamic> json) => _$GenresModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenresModelToJson(this);

  @override
  String toString() {
    return 'genresy{id: $id, name: $name, icon: $listMovie}';
  }
}

extension GenresModelX on GenresModel {
  GenresEntity toEntity() {
    return GenresEntity(
      id: id ?? "",
      name: name ?? "",
      listMovie: listMovie ?? [],
    );
  }
}
