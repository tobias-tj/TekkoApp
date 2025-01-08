import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/components/button_intro.dart';
import 'package:tekko/components/input_account.dart';
import 'package:tekko/components/input_animation.dart';
import 'package:tekko/screens/home_screen.dart';
import 'package:tekko/styles/app_colors.dart';

class CreateAccountStep extends StatefulWidget {
  const CreateAccountStep({
    super.key,
  });

  @override
  State<CreateAccountStep> createState() => _CreateAccountStepState();
}

class _CreateAccountStepState extends State<CreateAccountStep> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Controladores de texto para los inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Verificar respuesta matemática
  bool _isMathCorrect = false;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _goToNextStep() {
    if (_currentStep < 4) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToHome() {
    // Lógica para redirigir al Home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned.fill(
      top: size.height * 0.3,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Paso 1: Nombre
          _buildStep(
              title: '¿Cómo te llamas?',
              inputHint: 'Ingresa tu nombre',
              controller: _nameController,
              buttonText: 'SIGUIENTE',
              onPressed: _goToNextStep,
              inputType: TextInputType.name,
              isAge: false),
          // Paso 2: Edad
          _buildStep(
              title: '¿Cuántos años tienes?',
              inputHint: 'Ingresa tu edad',
              controller: _ageController,
              buttonText: 'CONFIRMAR',
              onPressed: _goToNextStep,
              inputType: TextInputType.number,
              isAge: true),
          // Paso 3: Espacio para padres
          _buildParentStep(),
          // Paso 4: Prueba matemática
          _buildMathTestStep(),
          // Paso 5: Correo y contraseña
          _buildAccountCreationStep(),
        ],
      ),
    );
  }

  Widget _buildStep(
      {required String title,
      required String inputHint,
      required TextEditingController controller,
      required String buttonText,
      required VoidCallback onPressed,
      required TextInputType inputType,
      required bool isAge}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.chocolateDark,
            ),
          ),
          const SizedBox(height: 20),
          InputAnimation(
            inputController: controller,
            hintText: inputHint,
            inputType: inputType,
            isAgeInput: isAge,
          ),
          const SizedBox(height: 20),
          ButtonIntro(onNext: onPressed, textButton: buttonText),
        ],
      ),
    );
  }

  Widget _buildParentStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Espacio Para Padres',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.chocolateDark,
          ),
        ),
        const SizedBox(height: 20),
        Lottie.asset('assets/animations/parentIconApp.json', height: 150),
        const SizedBox(height: 20),
        ButtonIntro(
          onNext: _goToNextStep,
          textButton: "Siguiente",
          isParent: true,
        )
      ],
    );
  }

  Widget _buildMathTestStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Prueba Matemática',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.chocolateDark,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          '¿Cuánto es 3 x 5?',
          style: TextStyle(fontSize: 22),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isMathCorrect = false;
                });
              },
              child: const Text('12'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isMathCorrect = true;
                });
                _goToNextStep();
              },
              child: const Text('15'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountCreationStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Correo Electrónico',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.chocolateDark),
          ),
          const SizedBox(height: 10),
          InputAccount(
            hintText: "Ejemplo@gmail.com",
            inputController: _emailController,
            isPass: false,
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          const Text(
            'Contraseña',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.chocolateDark),
          ),
          const SizedBox(height: 10),
          InputAccount(
            hintText: "Ingresa una contraseña",
            inputController: _passwordController,
            isPass: true,
            inputType: TextInputType.text,
          ),
          const SizedBox(height: 20),
          ButtonIntro(
            onNext: _goToHome,
            textButton: "Crear Cuenta",
            isParent: true,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.email, color: Colors.red),
                onPressed: () {
                  // Lógica para autenticación con Gmail
                },
              ),
              IconButton(
                icon: const Icon(Icons.facebook, color: Colors.blue),
                onPressed: () {
                  // Lógica para autenticación con Facebook
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
