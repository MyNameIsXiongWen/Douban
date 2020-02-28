import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetail {
  final String actors;
  final String country;
  final String directors;
  final String genres;
  final String language;
  final String poster;
  final String rated;
  final String rating;
  final String runtime;
  final String title;
  final String type;
  final String writers;
  @JsonKey(name: 'movieid')
  final String movieId;
  @JsonKey(name: 'also_known_as')
  final String alsoKnownAs;
  @JsonKey(name: 'film_locations')
  final String filmLocations;
  @JsonKey(name: 'plot_simple')
  final String plotSimple;
  @JsonKey(name: 'rating_count')
  final String ratingCount;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final String year;

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
    this.releaseDate,
    this.year,
  );

  factory MovieDetail.fromJson(Map<String, dynamic> json) => _$MovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);

  List<String> actorsToList() => this.actors.split(',');
}