import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:signal/fetch_movies.dart';
import 'package:signal/movie_repository.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  sl.registerLazySingleton(() => _createDio());
  sl.registerLazySingleton(() => FetchMovies(sl()));
  sl.registerLazySingleton(() => MovieRepository(sl()));
}

Dio _createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ),
  ); // Dio // BaseOptions
  dio.interceptors.add(InterceptorsWrapper(onRequest: ((options, handler) {
    options.queryParameters['api_key'] = '2b2ecc513d43ca197bb41969dd605be0';
    return handler.next(options);
  })));
  return dio;
}
