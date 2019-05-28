// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(json['movieId'] as String, json['movieName'] as String,
      json['pic_url'] as String);
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'movieId': instance.movieId,
      'movieName': instance.movieName,
      'pic_url': instance.picUrl
    };
