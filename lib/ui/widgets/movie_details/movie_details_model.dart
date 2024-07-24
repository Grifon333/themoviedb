import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/repositories/auth_repository.dart';
import 'package:themoviedb/domain/repositories/movie_repository.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieDetailsCastData {
  final String? _profilePath;
  final String name;
  final String character;

  Image get image {
    return _profilePath == null
        ? const Image(
            image: AssetImage(AppImages.userGrey),
            width: 120,
            height: 133,
          )
        : Image.network(
            ImageDownloader.makeImage(_profilePath!),
            width: 120,
            height: 133,
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
          );
  }

  MovieDetailsCastData({
    String? profilePath,
    required this.name,
    required this.character,
  }) : _profilePath = profilePath;
}

class MovieDetailsCrewData {
  final String name;
  final String job;

  MovieDetailsCrewData({
    required this.name,
    required this.job,
  });
}

class MovieDetailsGenreData {
  final String certification;
  final String date;
  final String productionCountry;
  final String runtime;
  final String genres;

  MovieDetailsGenreData({
    required this.certification,
    required this.date,
    required this.productionCountry,
    required this.runtime,
    required this.genres,
  });
}

class MovieDetailsScoreMovieData {
  final double score;
  final String? youtubeKey;

  MovieDetailsScoreMovieData({
    required this.score,
    this.youtubeKey,
  });

  String get scoreStr => (score * 100).toStringAsFixed(0);
}

class MovieDetailsPosterData {
  final String? backdropPath;
  final String? posterPath;

  MovieDetailsPosterData({
    this.backdropPath,
    this.posterPath,
  });
}

class MovieDetailsData {
  String title = 'Loading...';
  String year = '';
  bool _isFavorite = false;
  String? tagline;
  String overview = '';
  List<List<MovieDetailsCrewData>> crewDatMatrix = [];
  List<MovieDetailsCastData> castDataList = [];
  bool isLoading = false;
  MovieDetailsPosterData posterData = MovieDetailsPosterData();
  MovieDetailsScoreMovieData scoreMovieData = MovieDetailsScoreMovieData(
    score: 0,
  );
  MovieDetailsGenreData genreData = MovieDetailsGenreData(
    certification: '',
    date: '',
    productionCountry: '',
    runtime: '',
    genres: '',
  );

  IconData get favoriteIcon =>
      _isFavorite ? Icons.favorite : Icons.favorite_outline;
}

class MovieDetailsModel extends ChangeNotifier {
  final BuildContext context;
  final _authRepository = AuthRepository();
  final _movieRepository = MovieRepository();
  final _data = MovieDetailsData();

  int movieId;
  String _locale = '';
  String _countryCode = '';
  late DateFormat _dateFormat;

  static const Set<String> _mainJobs = {
    'Author',
    'Characters',
    'Director',
    'Novel',
    'Screenplay',
    'Story',
    'Teleplay',
    'Writer',
  };

  MovieDetailsData get data => _data;

  MovieDetailsModel(
    this.context, {
    required this.movieId,
  });

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final countryCode = Localizations.localeOf(context).countryCode ?? 'US';
    if (locale == _locale || countryCode == _countryCode) return;
    _locale = locale;
    _countryCode = countryCode;
    _dateFormat = DateFormat.yMd(locale);
    await _loadDetails();
  }

  Future<void> _loadDetails() async {
    try {
      if (_data.isLoading) return;
      _data.isLoading = true;
      notifyListeners();
      final (MovieDetails, bool, String) details =
          await _movieRepository.loadDetails(
        _locale,
        movieId,
        _countryCode,
      );
      _loadData(details);
      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  void _loadData((MovieDetails, bool, String) details) {
    MovieDetails movieDetails = details.$1;
    _data.title = movieDetails.title;
    _data._isFavorite = details.$2;
    _data.posterData = MovieDetailsPosterData(
      backdropPath: movieDetails.backdropPath,
      posterPath: movieDetails.posterPath,
    );
    _data.year = ' (${movieDetails.releaseDate.year})';
    _loadScareMovieData(movieDetails);
    _loadGenreData(details);
    _data.tagline = movieDetails.tagline;
    _data.overview = movieDetails.overview ?? '';
    _loadCrew(movieDetails, 2);
    _loadCast(movieDetails);
    _data.isLoading = false;
  }

  void _loadGenreData((MovieDetails, bool, String) details) {
    MovieDetails movieDetails = details.$1;
    final certification = details.$3;
    final releaseDate = movieDetails.releaseDate;
    String date = _dateFormat.format(releaseDate);
    final productionCountry = movieDetails.productionCountries[0].iso;
    final timeInMinutes = movieDetails.runtime ?? 0;
    var hours = (timeInMinutes ~/ 60).toString();
    if (hours != '0') {
      hours = '$hours h';
    }
    final minutes = '${(timeInMinutes % 60).toStringAsFixed(0)} m';
    final runtime = '$hours $minutes';
    final genres =
        movieDetails.genres.map<String>((e) => e.name).toList().join(', ');
    _data.genreData = MovieDetailsGenreData(
      certification: certification,
      date: date,
      productionCountry: productionCountry,
      runtime: runtime,
      genres: genres,
    );
  }

  void _loadScareMovieData(MovieDetails movieDetails) {
    final score = movieDetails.voteAverage / 10;
    final videos = movieDetails.videos;
    String? youtubeKey;
    if (videos.results.isNotEmpty) {
      final list = videos.results.where((video) =>
          video.site == 'YouTube' &&
          video.type == 'Trailer' &&
          video.official == true);
      if (list.isNotEmpty) {
        youtubeKey = list.first.key;
      }
    }
    _data.scoreMovieData = MovieDetailsScoreMovieData(
      score: score,
      youtubeKey: youtubeKey,
    );
  }

  void _loadCrew(MovieDetails movieDetails, int countColumns) {
    final crewDataList = movieDetails.credits.crew
        .where((crew) => _mainJobs.contains(crew.job))
        .map((e) => MovieDetailsCrewData(name: e.name, job: e.job))
        .toList();
    crewDataList.sort((a, b) => a.job.compareTo(b.job));
    int remainder = crewDataList.length % countColumns;
    if (remainder != 0) {
      crewDataList.addAll(List.filled(
        countColumns - remainder,
        MovieDetailsCrewData(name: '', job: ''),
      ));
    }
    List<List<MovieDetailsCrewData>> crewDataMatrix = List.generate(
      crewDataList.length ~/ countColumns,
      (row) => List.generate(
        countColumns,
        (column) => crewDataList[row * countColumns + column],
      ),
    );
    _data.crewDatMatrix = crewDataMatrix;
  }

  void _loadCast(MovieDetails movieDetails) {
    _data.castDataList = movieDetails.credits.cast
        .map((e) => MovieDetailsCastData(
              profilePath: e.profilePath,
              name: e.name,
              character: e.character,
            ))
        .toList();
  }

  Future<void> updateFavorite(BuildContext context) async {
    data._isFavorite ^= true;
    notifyListeners();
    try {
      await _movieRepository.updateFavorite(movieId, data._isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  void _handleApiClientException(ApiClientException exception) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        _authRepository.logout();
        MainNavigation.goLoader(context);
        break;
      default:
        debugPrint(exception.toString());
    }
  }
}
