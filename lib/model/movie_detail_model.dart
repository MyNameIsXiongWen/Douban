import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetail {
  String actors;
  String country;
  String directors;
  String genres;
  String language;
  String poster;
  String rated;
  String rating;
  String runtime;
  String title;
  String type;
  String writers;
  @JsonKey(name: 'movieid')
  String movieId;
  @JsonKey(name: 'also_known_as')
  String alsoKnownAs;
  @JsonKey(name: 'film_locations')
  String filmLocations;
  @JsonKey(name: 'plot_simple')
  String plotSimple;
  @JsonKey(name: 'rating_count')
  String ratingCount;
//  @JsonKey(name: 'release_date')
//  int releaseDate;
//  int year;

  MovieDetail(
      this.actors,
      this.country,
      this.directors,
      this.genres,
      this.language,
      this.poster,
      this.rated,
      this.rating,
      this.runtime,
      this.title,
      this.type,
      this.writers,
      this.movieId,
      this.alsoKnownAs,
      this.filmLocations,
      this.plotSimple,
      this.ratingCount,
//      this.releaseDate,
//      this.year,
      );

  factory MovieDetail.fromJson(Map<String, dynamic> json) => _$MovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);

  List<String> actorsToList() => this.actors.split(',');
}