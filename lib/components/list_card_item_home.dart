import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/styles/app_colors.dart';

class ListCardItemHome extends StatelessWidget {
  final int id;
  final String imagePath;
  final String title;
  const ListCardItemHome(
      {super.key,
      required this.id,
      required this.imagePath,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/word-screen/$id/$title'),
      child: Card(
        color: AppColors.chocolateDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 150,
            maxWidth: 150,
            minHeight: 150,
            maxHeight: 150,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  imagePath,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Text(title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.softCream,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
