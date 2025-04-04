import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekko/app_routes.dart';
import 'package:tekko/features/auth/data/bloc/experience/experience_bloc.dart';
import 'package:tekko/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tekko/features/auth/data/bloc/auth_bloc.dart';
import 'package:tekko/features/auth/data/datasources/kids_remote_datasource.dart';
import 'package:tekko/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tekko/features/auth/data/repositories/kids_repository_impl.dart';
import 'package:tekko/features/auth/domain/usecases/get_experience.dart';
import 'package:tekko/features/auth/domain/usecases/login_usecase.dart';
import 'package:tekko/features/auth/domain/usecases/register_usecase.dart';
import 'package:tekko/features/core/network/dio_client.dart';

void main() {
  runApp(const MainApp());
}

final dioClient = DioClient();

// Configuracion de Auth
final authRemoteDataSource = AuthRemoteDataSource(dio: dioClient.dio);
final authRepository =
    AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
final registerUseCase = RegisterUseCase(repository: authRepository);
final loginUseCase = LoginUsecase(repository: authRepository);
final authBloc =
    AuthBloc(registerUseCase: registerUseCase, loginUsecase: loginUseCase);

// Configuracion de Experience
final kidsRemoteDataSource = KidsRemoteDatasource(dio: dioClient.dio);
final kidRepository =
    KidsRepositoryImpl(remoteDataSource: kidsRemoteDataSource);
final getExperienceUseCase = GetExperience(kidRepository);
final experienceBloc = ExperienceBloc(getExperience: getExperienceUseCase);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: authBloc),
          BlocProvider<ExperienceBloc>.value(value: experienceBloc),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
        ));
  }
}
