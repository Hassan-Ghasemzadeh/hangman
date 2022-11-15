import 'package:hangman/features/auth/data/models/user.dart';

abstract class IUserRepository {
  Future<User> loginUser(String name, String password);
  Future<User> signUp(String name, String password);
}
