import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/movie_details_videos.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';

part 'movie_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetails {
  bool adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int budget;
  List<Genre> genres;
  String? homepage;
  int id;
  String? imdbId;
  String originalLanguage;
  String originalTitle;
  String? overview;
  double popularity;
  String? posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  DateTime releaseDate;
  int revenue;
  int? runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String? tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  MovieDetailsCredits credits;
  MovieDetailsVideos videos;

  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.credits,
    required this.videos,
  });

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BelongsToCollection {
  BelongsToCollection();

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$GenreToJson(this);

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompany {
  String name;
  int id;
  String? logoPath;
  String originCountry;

  ProductionCompany({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountry {
  @JsonKey(name: 'iso_3166_1')
  String iso;
  String name;

  ProductionCountry({
    required this.iso,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguage {
  @JsonKey(name: 'iso_639_1')
  String iso;
  String name;

  SpokenLanguage({
    required this.iso,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);
}
