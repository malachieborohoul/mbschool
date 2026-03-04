import 'package:fpdart/fpdart.dart';
import 'package:mbschool/core/error/failures.dart';


typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultNF<T> = Either<Failure, T>;
