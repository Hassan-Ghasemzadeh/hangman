import 'package:get_it/get_it.dart';

import '../../../../core/usecase_tool/usecase_tool.dart';
import '../../data/entity/login_entity.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository_impl.dart';

class SignUpUseCase extends IUseCase<User, LoginEntity> {
  UserRepository get repository => GetIt.I.get<UserRepository>();
  @override
  Future<User> invoke(LoginEntity params) {
    return repository.signUp(
      params.username,
      params.password,
    );
  }
}
