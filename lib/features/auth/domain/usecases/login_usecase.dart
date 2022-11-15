import 'package:get_it/get_it.dart';
import 'package:hangman/core/usecase_tool/usecase_tool.dart';
import 'package:hangman/features/auth/data/models/user.dart';

import '../../data/entity/login_entity.dart';
import '../../data/repositories/user_repository_impl.dart';

class LoginUseCase extends IUseCase<User, LoginEntity> {
  UserRepository get repository => GetIt.I.get<UserRepository>();
  @override
  Future<User> invoke(LoginEntity params) {
    return repository.loginUser(
      params.username,
      params.password,
    );
  }
}
