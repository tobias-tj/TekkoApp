import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekko/app_routes.dart';
import 'package:tekko/features/auth/data/bloc/experience/experience_bloc.dart';
import 'package:tekko/features/auth/data/bloc/security_pin/security_pin_bloc.dart';
import 'package:tekko/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tekko/features/auth/data/bloc/auth_bloc.dart';
import 'package:tekko/features/auth/data/datasources/kids_remote_datasource.dart';
import 'package:tekko/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tekko/features/auth/data/repositories/kids_repository_impl.dart';
import 'package:tekko/features/auth/domain/usecases/get_experience.dart';
import 'package:tekko/features/auth/domain/usecases/login_usecase.dart';
import 'package:tekko/features/auth/domain/usecases/register_usecase.dart';
import 'package:tekko/features/auth/domain/usecases/verify_security_pin.dart';
import 'package:tekko/features/core/network/dio_client.dart';

void main() {
  runApp(const MainApp());
}

final class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DioClient>(
          create: (_) => DioClient(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              registerUseCase: RegisterUseCase(
                repository: AuthRepositoryImpl(
                  remoteDataSource: AuthRemoteDataSource(
                    dio: context.read<DioClient>().dio,
                  ),
                ),
              ),
              loginUsecase: LoginUsecase(
                repository: AuthRepositoryImpl(
                  remoteDataSource: AuthRemoteDataSource(
                    dio: context.read<DioClient>().dio,
                  ),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => ExperienceBloc(
              getExperience: GetExperience(
                KidsRepositoryImpl(
                  remoteDataSource: KidsRemoteDatasource(
                    dio: context.read<DioClient>().dio,
                  ),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => SecurityPinBloc(
              verifySecurityPin: VerifySecurityPinUseCase(
                repository: AuthRepositoryImpl(
                  remoteDataSource: AuthRemoteDataSource(
                    dio: context.read<DioClient>().dio,
                  ),
                ),
              ),
            ),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
