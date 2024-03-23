import 'package:json_annotation/json_annotation.dart';

part 'movie_details_videos.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsVideos {
  final List<Results> results;

  MovieDetailsVideos({
    required this.results,
  });

  Map<String, dynamic> toJson() => _$MovieDetailsVideosToJson(this);

  factory MovieDetailsVideos.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVideosFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Results {
  final String iso_639_1;
  final String iso_3166_1;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  Results({
    required this.iso_639_1,
    required this.iso_3166_1,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
}
