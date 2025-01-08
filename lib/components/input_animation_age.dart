import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tekko/styles/app_colors.dart';

class InputAnimationAge extends StatefulWidget {
  final TextEditingController inputController;

  const InputAnimationAge({super.key, required this.inputController});

  @override
  State<InputAnimationAge> createState() => _InputAnimationAgeState();
}

class _InputAnimationAgeState extends State<InputAnimationAge> {
  String _userInput = "";

  @override
  void initState() {
    super.initState();

    widget.inputController.addListener(() {
      final newText = widget.inputController.text;
      if (newText.length <= 2) {
        if (_userInput != newText) {
          setState(() {
            _userInput = newText;
          });
        }
      } else {
        widget.inputController.text = _userInput;
        widget.inputController.selection = TextSelection.fromPosition(
          TextPosition(offset: _userInput.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Abre el teclado al tocar el widget
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(2, (index) {
                // Solo 2 espacios para la edad
                final letter = index < _userInput.length
                    ? _userInput[index]
                    : ""; // Letra o espacio vacío
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      Text(
                        letter,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.chocolateDark,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 20,
                        color: index < _userInput.length
                            ? AppColors.chocolateDark
                            : Colors.grey[400],
                        margin: const EdgeInsets.only(top: 4.0),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          Opacity(
            opacity: 0.0, // Hace que el campo de texto sea invisible
            child: TextField(
              controller: widget.inputController,
              keyboardType: TextInputType.number, // Tipo numérico para edad
              maxLength: 2, // Limita a 2 caracteres para la edad
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Solo números
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: "", // Oculta el contador de caracteres
              ),
              cursorColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
