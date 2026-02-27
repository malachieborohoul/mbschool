import 'package:fpdart/fpdart.dart';
import 'package:mbschool/core/error/error_repo_handler.dart';
import 'package:mbschool/core/error/exceptions.dart';
import 'package:mbschool/core/error/failures.dart';
import 'package:mbschool/core/network/connection_checker.dart';
import 'package:mbschool/core/utils/typedef.dart';
import 'package:mbschool/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mbschool/features/auth/data/models/user_model.dart';
import 'package:mbschool/features/auth/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  // final AuthLocalDatasource authLocalDatasource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(
    this.authRemoteDataSource,
    this.connectionChecker,
    // this.authLocalDatasource,
  );



  @override
  ResultFuture<UserModel> signIn(
      {required String email,
      required String password}) async {
    return errorRepoHandler(() async {
      return await authRemoteDataSource.signIn(email: email, password: password);
    }, connectionChecker);
  }

  @override
  ResultFuture<UserModel> signUp(
      {
    required String name,
    required String prenom,
    required String email,
    required String password,
      
      }) async {
    return errorRepoHandler(() async {
      return await authRemoteDataSource.signUp(name: name, prenom: prenom, email: email, password: password);
    }, connectionChecker);
  }

  @override
  ResultFuture<UserModel> currentUserApi() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        // final session = authRemoteDataSource.currentUserSession;

        // if (session == null) {
        //   return left(Failure("User not logged in!"));
        // }

        // final user = authLocalDatasource.getCachedProfil();

        // if (user == null) {
        //   return left(Failure("User not cached!"));
        // }

        // return right(user);
        return left(Failure(message: ''));
      }
      final user = await authRemoteDataSource.getCurrentUserApi();

      // if (user == null) {
      //   return left(Failure("User not logged in!"));
      // }

      // authLocalDatasource.addCachedProfil(user: user);

      return right(user);
    }
    // on AuthException catch (e) {
    //   return left(Failure(e.message));
    // }

    on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  ResultFuture<bool> signOut() async {

     return errorRepoHandler(() async {
      return await authRemoteDataSource.signOut();
    }, connectionChecker);
    // try {
    //   await authRemoteDataSource.signOut();

    //   return right(null);
    // }
    // // on AuthException catch (e) {
    // //   return left(Failure(e.message));
    // // }
    // on ServerException catch (e) {
    //   return left(Failure(e.message));
    // }
  }



  @override
  ResultFuture<UserModel> initApp() async {
    //    try {
    //   final res =  await authRemoteDataSource.init();

    //   return right(res );
    // }
    // // on AuthException catch (e) {
    // //   return left(Failure(e.message));
    // // }
    // on ServerException catch (e) {
    //   return left(Failure(e.message));
    // }

    return errorRepoHandler(() async {
      return await authRemoteDataSource.init();
    }, connectionChecker);
  }

  @override
  ResultFuture<String?> getAccessToken() async {
    return errorRepoHandler(() async {
      return await authRemoteDataSource.getAccessToken();
    }, connectionChecker);
  }

  @override
  ResultFuture<bool> refreshToken() async {
    return errorRepoHandler(() async {
      return await authRemoteDataSource.refreshToken();
    }, connectionChecker);
  }
}
