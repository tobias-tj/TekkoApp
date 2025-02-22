import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/styles/app_colors.dart';

class ParentPinScreen extends StatelessWidget {
  const ParentPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Ingrese el PIN para activar el Modo Padres",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.chocolateNewDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "PIN",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.pushReplacement('/splash?mode=parent');
                  //context.push('/word-screen/$id/$title')
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.chocolateNewDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 12.0),
                ),
                child: const Text(
                  "Confirmar",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
