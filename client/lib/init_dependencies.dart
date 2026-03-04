
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:mbschool/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mbschool/core/network/connection_checker.dart';
import 'package:mbschool/core/network/custom_http_client.dart';
import 'package:mbschool/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mbschool/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mbschool/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbschool/features/auth/domain/usecases/init_app.dart';
import 'package:mbschool/features/auth/domain/usecases/sign_in.dart';
import 'package:mbschool/features/auth/domain/usecases/sign_up.dart';
import 'package:mbschool/features/auth/domain/usecases/user_current_user.dart';
import 'package:mbschool/features/auth/domain/usecases/user_sign_out.dart';
import 'package:mbschool/features/auth/presentation/bloc/auth_bloc.dart';


part 'init_dependencies.main.dart';
