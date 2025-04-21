import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekko/components/list_card_item_home.dart';
import 'package:tekko/components/top_custom_background.dart';
import 'package:tekko/data/list_item_home.dart';
import 'package:tekko/features/api/data/bloc/experience/experience_bloc.dart';
import 'package:tekko/styles/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> items = ItemData.getAll();
  int levelCurrent = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Column(
        children: [
          // Encabezado con animación
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: const TopCustomBackground(),
          ),

          const SizedBox(height: 2),

          // BlocBuilder espera a que el estado esté listo
          Expanded(
            child: BlocBuilder<ExperienceBloc, ExperienceState>(
              builder: (context, state) {
                if (state is ExperienceLoaded) {
                  final levelCurrent = state.experience.level;
                  final items = ItemData.getAll();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7, // Más rectangulares
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isLocked = levelCurrent < item.level;

                        return FadeInUp(
                          duration: Duration(milliseconds: 500 + (index * 100)),
                          child: SizedBox(
                            width: 120, // Ancho fijo
                            height: 150,
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: isLocked ? 0.5 : 1.0,
                                  child: IgnorePointer(
                                    ignoring: isLocked,
                                    child: ListCardItemHome(
                                      id: item.id,
                                      imagePath: item.imagePath,
                                      title: item.title,
                                    ),
                                  ),
                                ),
                                if (isLocked)
                                  const Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.lock,
                                        size: 40,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
