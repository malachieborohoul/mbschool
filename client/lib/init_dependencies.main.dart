part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();


    final secureStorage = FlutterSecureStorage(
      // aOptions: const AndroidOptions(
      //   encryptedSharedPreferences: true
      // ),
      // iOptions: IOSOptions(
      //   accessibility: KeychainAccessibility.first_unlock
      // )
      );


  serviceLocator.registerLazySingleton(() => secureStorage);


  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => http.Client());

  //core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );

  serviceLocator
    .registerFactory<CustomHttpClient>(
      () => CustomHttpClient(
        serviceLocator(), // HttpClient
        serviceLocator(), // AuthRepository
      ),
    );
}



void _initAuth() {
  //Datasource

  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // ..registerFactory<AuthLocalDatasource>(
    //   () => AuthLocalDatasourceImpl(
    //     serviceLocator(),
    //   ),
    // )

    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        // serviceLocator(),
      ),
    )

    //Usecases

    ..registerFactory(
      () => InitApp(
        serviceLocator(),
      ),
    )

     ..registerFactory(
      () => SignIn(
        serviceLocator(),
      ),
    )

     ..registerFactory(
      () => SignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignOut(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserCurrentUser(
        serviceLocator(),
      ),
    )
    

    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        initApp: serviceLocator(),
        appUserCubit: serviceLocator(),
        userSignOut: serviceLocator(),
        userCurrentUser: serviceLocator(),

        signIn: serviceLocator(),
        signUp: serviceLocator(),
      ),
    );
}
