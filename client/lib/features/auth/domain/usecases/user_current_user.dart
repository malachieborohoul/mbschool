import 'package:mbschool/core/domain/entities/user.dart';
import 'package:mbschool/core/usecase/usecase.dart';
import 'package:mbschool/core/utils/typedef.dart';
import 'package:mbschool/features/auth/domain/repositories/auth_repository.dart';



class UserCurrentUser implements UsecaseWithoutParams<User?> {
  final AuthRepository authRepository;

  UserCurrentUser(this.authRepository);
  @override
  ResultFuture<User> call() async {
        return await authRepository.currentUserApi();

  }
}

