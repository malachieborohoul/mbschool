



import 'package:mbschool/core/usecase/usecase.dart';
import 'package:mbschool/core/utils/typedef.dart';
import 'package:mbschool/features/auth/domain/repositories/auth_repository.dart';

class UserSignOut implements UsecaseWithoutParams<void> {
  final AuthRepository authRepository;

  UserSignOut(this.authRepository);
  @override
  ResultFuture<void> call() async{
    return await authRepository.signOut();
  }
}

