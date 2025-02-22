import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/components/button_intro.dart';
import 'package:tekko/components/input_animation.dart';
import 'package:tekko/components/math_question.dart';
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

  // Variables para la prueba matemática
  MathQuestion? _currentQuestion;
  int? _userAnswer;
  int _attempts = 0;
  final int _maxAttempts = 3; // Número máximo de intentos
  bool _isMathCorrect = false;

  @override
  void initState() {
    super.initState();
    _generateNewQuestion();
  }

  void _generateNewQuestion() {
    setState(() {
      _currentQuestion = generateMathQuestion();
      _userAnswer = null;
    });
  }

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
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentStep == 3) {
      // Redirigir a RegisterAccount después de completar el paso 4
      context.go('/register');
    }
  }

  void _checkAnswer(int answer) {
    setState(() {
      _userAnswer = answer;
      if (answer == _currentQuestion?.correctAnswer) {
        _isMathCorrect = true;
        _goToNextStep(); // Avanzar al siguiente paso si la respuesta es correcta
      } else {
        _attempts++;
        if (_attempts >= _maxAttempts) {
          // Mostrar un mensaje de error y reiniciar la prueba
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Durations.short3,
              content: Text(
                  'Has excedido el número máximo de intentos. Intenta de nuevo.'),
            ),
          );
          _attempts = 0;
          _generateNewQuestion();
        } else {
          // Mostrar un mensaje de error y generar una nueva pregunta
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Durations.short3,
              content: Text('Respuesta incorrecta. Intenta de nuevo.'),
            ),
          );
          _generateNewQuestion();
        }
      }
    });
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
          // // Paso 5: Correo y contraseña
          // _buildAccountCreationStep(),
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
    if (_currentQuestion == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Combinar respuestas correctas e incorrectas y mezclarlas
    final allAnswers = [
      _currentQuestion!.correctAnswer,
      ..._currentQuestion!.incorrectAnswers,
    ]..shuffle();

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
        Text(
          _currentQuestion!.question,
          style: const TextStyle(fontSize: 22),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: allAnswers.map((answer) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: () {
                  _checkAnswer(answer);
                },
                child: Text(answer.toString()),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Text(
          'Intentos restantes: ${_maxAttempts - _attempts}',
          style: const TextStyle(fontSize: 16, color: Colors.red),
        ),
      ],
    );
  }
}
