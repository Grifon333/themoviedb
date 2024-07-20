import 'package:themoviedb/domain/configuration/configuration.dart';

class ImageDownloader {
  static String makeImage(String path) => Configuration.imageUrl + path;
}