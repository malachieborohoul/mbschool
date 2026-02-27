  import 'package:fpdart/fpdart.dart';
import 'package:mbschool/core/error/exceptions.dart';
import 'package:mbschool/core/error/failures.dart';
import 'package:mbschool/core/network/connection_checker.dart';
import 'package:mbschool/core/secrets/app_secrets.dart';
import 'package:mbschool/core/utils/typedef.dart';


ResultFuture<T> errorRepoHandler<T> (Future<T> Function() fn,
  ConnectionChecker connectionChecker,)async{
try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(message:  'Pas de connexion internet', statusCode: AppSecrets.ERROR_NETWORK));
      }
      final res = await fn();

      return right(res);
    }
    // on AuthException catch (e) {
    //   return left(Failure(e.message));
    // }

    on ServerException catch (e) {
      return left(Failure( message: e.message, code: e.code ?? "", statusCode: e.statusCode ?? ""));
    }
  }
  