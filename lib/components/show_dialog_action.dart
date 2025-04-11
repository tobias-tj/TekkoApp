import 'package:flutter/material.dart';
import 'package:tekko/features/auth/data/models/activity_kid_dto.dart';
import 'package:tekko/features/core/utils/format_date.dart';
import 'package:tekko/styles/app_colors.dart';

Future<dynamic> showDialogAction(
    BuildContext context, ActivityKidDto activity) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          activity.titleActivity,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Descripción:",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.chocolateDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(activity.descriptionActivity),
            Text(
              "Inicia:",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.chocolateDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(formatDatePretty(activity.startActivityTime)),
            Text(
              "Tiempo Maximo:",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.chocolateDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(formatDatePretty(activity.expirationActivityTime)),
            Text(
              "Experiencia:",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.chocolateDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "+${activity.experienceActivity} EXP",
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      );
    },
  );
}
