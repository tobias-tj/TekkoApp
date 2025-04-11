import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tekko/app_routes.dart';
import 'package:tekko/features/auth/data/bloc/activity/activity_bloc.dart';
import 'package:tekko/features/auth/data/bloc/experience/experience_bloc.dart';
import 'package:tekko/features/auth/data/bloc/security_pin/security_pin_bloc.dart';
import 'package:tekko/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tekko/features/auth/data/bloc/auth_bloc.dart';
import 'package:tekko/features/auth/data/datasources/kids_remote_datasource.dart';
import 'package:tekko/features/auth/data/datasources/parent_remote_datasource.dart';
import 'package:tekko/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tekko/features/auth/data/repositories/kids_repository_impl.dart';
import 'package:tekko/features/auth/data/repositories/parent_repository_impl.dart';
import 'package:tekko/features/auth/domain/usecases/create_activity.dart';
import 'package:tekko/features/auth/domain/usecases/get_activities.dart';
import 'package:tekko/features/auth/domain/usecases/get_activities_by_kid.dart';
import 'package:tekko/features/auth/domain/usecases/get_experience.dart';
import 'package:tekko/features/auth/domain/usecases/login_usecase.dart';
import 'package:tekko/features/auth/domain/usecases/register_usecase.dart';
import 'package:tekko/features/auth/domain/usecases/update_activity.dart';
import 'package:tekko/features/auth/domain/usecases/verify_security_pin.dart';
import 'package:tekko/features/core/network/dio_client.dart';
import 'package:tekko/styles/app_colors.dart';

void main() async {
  await initializeDateFormatting('es');
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
          BlocProvider(
            create: (context) => ActivityBloc(
                createActivity: CreateActivityUseCases(
                    repository: ParentRepositoryImpl(
                        remoteDataSource: ParentRemoteDatasource(
                            dio: context.read<DioClient>().dio))),
                getActivities: GetActivitiesUseCases(
                    repository: ParentRepositoryImpl(
                        remoteDataSource: ParentRemoteDatasource(
                            dio: context.read<DioClient>().dio))),
                getActivitiesByKid: GetActivitiesByKidUseCases(
                    repository: KidsRepositoryImpl(
                        remoteDataSource: KidsRemoteDatasource(
                            dio: context.read<DioClient>().dio))),
                updateActivity: UpdateActivityUseCases(
                    repository: KidsRepositoryImpl(
                        remoteDataSource: KidsRemoteDatasource(
                            dio: context.read<DioClient>().dio)))),
          )
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.cardBackgroundSoft,
            ),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
