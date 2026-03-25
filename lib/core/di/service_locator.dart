import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sayyor/features/authentification/domain/usecase/refresh_token_usecase.dart';

import '../../features/authentification/data/datasource/auth_remote_datasource.dart';
import '../../features/authentification/data/repository/auth_repository_impl.dart';
import '../../features/authentification/domain/repository/auth_repository.dart';
import '../../features/authentification/domain/usecase/send_otp_usecase.dart';
import '../../features/authentification/domain/usecase/verify_otp_usecase.dart';
import '../../features/authentification/presentation/bloc/auth_bloc.dart';
import '../networks/dio_client.dart';
import '../storage/localstorage.dart';
import '../storage/token_storage.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  const secureStorage = FlutterSecureStorage();
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => LocalStorage(sl()));
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => TokenStorage(sl()));
  sl.registerLazySingleton(() => DioClient(sl()));
  sl.registerLazySingleton<AuthRemoteDatasourceImpl>(
    () => AuthRemoteDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () =>
        AuthRepositoryImpl(authRemoteDatasourceImpl: sl(), tokenStorage: sl()),
  );
  sl.registerLazySingleton(() => SendOtpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(authRepository: sl()));

  sl.registerFactory(
    () => AuthBloc(
      verifyOtpUseCase: sl(),
      refreshTokenUseCase: sl(),
      sendOtpUseCase: sl(),
    ),
  );
}
