import 'package:themoviedb/domain/data_providers/user_data_provider.dart';
import 'package:themoviedb/domain/entity/user.dart';

class UserRepository {
  User? _user;
  final UserDataProvider _userDataProvider = UserDataProvider();

  Future<User?> getUser() async {
    return _user ?? await _userDataProvider.getUser();
  }
}