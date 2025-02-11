import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/components/top_custom_title.dart';
import 'package:tekko/styles/app_colors.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<Map<String, dynamic>> games = [
    {
      "title": "Dibujo Libre",
      "image": "assets/images/activities/paintIcon.png",
      "route": "/drawing"
    },
    {
      "title": "Numeros",
      "image": "assets/images/activities/numberIcon.png",
      "route": "/numbers"
    },
    {
      "title": "Memorias",
      "image": "assets/images/activities/readIcon.png",
      "route": "/memory"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Column(
        children: [
          TopCustomTitle(title: 'Actividades'),
          const SizedBox(height: 6),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  final game = games[index];
                  return GestureDetector(
                    onTap: () => context.go(game["route"]),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 4,
                        child: ListTile(
                          leading: Image.asset(game["image"]!, width: 50),
                          title: Text(game["title"]!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          trailing: const Icon(Icons.play_arrow,
                              color: AppColors.chocolateNewDark),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
