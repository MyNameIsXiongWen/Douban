import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class Movie {
  String movieId;
  String movieName;
  @JsonKey(name: 'pic_url')
  String picUrl;

  Movie(this.movieId, this.movieName, this.picUrl);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}