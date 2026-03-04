import 'package:mbschool/core/utils/typedef.dart';

abstract interface class Usecase<SuccessType, Params> {
  ResultFuture<SuccessType> call(Params params);
}

abstract interface class UsecaseWithoutParams<SuccessType> {
  ResultFuture<SuccessType> call();
}

