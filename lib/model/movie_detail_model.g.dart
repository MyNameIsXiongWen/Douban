// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetail _$MovieDetailFromJson(Map<String, dynamic> json) {
  return MovieDetail(
      json['actors'] as String,
      json['country'] as String,
      json['directors'] as String,
      json['genres'] as String,
      json['language'] as String,
      json['poster'] as String,
      json['rated'] as String,
      json['rating'] as String,
      json['runtime'] as String,
      json['title'] as String,
      json['type'] as String,
      json['writers'] as String,
      json['movieid'] as String,
      json['also_known_as'] as String,
      json['film_locations'] as String,
      json['plot_simple'] as String,
      json['rating_count'] as String,
      json['release_date'] as String,
      json['year'] as String);
}

Map<String, dynamic> _$MovieDetailToJson(MovieDetail instance) =>
    <String, dynamic>{
      'actors': instance.actors,
      'country': instance.country,
      'directors': instance.directors,
      'genres': instance.genres,
      'language': instance.language,
      'poster': instance.poster,
      'rated': instance.rated,
      'rating': instance.rating,
      'runtime': instance.runtime,
      'title': instance.title,
      'type': instance.type,
      'writers': instance.writers,
      'movieid': instance.movieId,
      'also_known_as': instance.alsoKnownAs,
      'film_locations': instance.filmLocations,
      'plot_simple': instance.plotSimple,
      'rating_count': instance.ratingCount,
      'release_date': instance.releaseDate,
      'year': instance.year
    };
