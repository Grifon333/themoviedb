import 'package:themoviedb/domain/data_providers/session_data_provider.dart';

class AuthRepository {
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    return sessionId != null;
  }
}