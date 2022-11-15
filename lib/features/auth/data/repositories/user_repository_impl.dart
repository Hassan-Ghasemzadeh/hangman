import 'package:hangman/features/auth/data/data_source/user_data_source.dart';
import 'package:hangman/features/auth/data/models/user.dart';
import 'package:hangman/features/auth/domain/repositories/user_repository.dart';

class UserRepository extends IUserRepository {
  final UserDataSource source;
  UserRepository({
    required this.source,
  });
  @override
  Future<User> loginUser(String name, String password) {
    return source.loginUser(name, password);
  }

  @override
  Future<User> signUp(String name, String password) {
    return source.signUp(name, password);
  }
}
