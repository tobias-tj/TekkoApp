import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tekko/styles/app_colors.dart';

class InputAnimationName extends StatefulWidget {
  final String hintText;
  final TextInputType inputType;
  final TextEditingController inputController;
  final bool isAgeInput; // Nueva bandera

  const InputAnimationName({
    super.key,
    required this.inputController,
    required this.hintText,
    required this.inputType,
    this.isAgeInput = false, // Por defecto es false
  });

  @override
  State<InputAnimationName> createState() => _InputAnimationNameState();
}

class _InputAnimationNameState extends State<InputAnimationName> {
  String _userInput = "";

  @override
  void initState() {
    super.initState();

    widget.inputController.addListener(() {
      final newText = widget.inputController.text;
      if (widget.isAgeInput) {
        // Limita la longitud a 2 caracteres para la edad
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
      } else {
        // Para otros casos (texto), puedes usar la lógica que ya tienes
        if (newText.length <= 10) {
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
              children: List.generate(10, (index) {
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
                        color: index <
                                (_userInput.length <
                                        (widget.isAgeInput ? 2 : 10)
                                    ? _userInput.length
                                    : (widget.isAgeInput ? 2 : 10))
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
              keyboardType: widget.isAgeInput
                  ? TextInputType.number // Si es para edad, tipo numérico
                  : widget.inputType,
              maxLength: widget.isAgeInput ? 2 : 10, // Limita a 2 para edad
              inputFormatters: [
                if (widget.isAgeInput)
                  FilteringTextInputFormatter
                      .digitsOnly, // Solo números para la edad
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: "", // Oculta el contador de caracteres
              ),
              cursorColor: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
