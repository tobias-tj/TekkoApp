import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/components/button_intro.dart';
import 'package:tekko/components/google_button.dart';
import 'package:tekko/features/api/data/models/auth_model.dart';
import 'package:tekko/features/api/data/bloc/auth_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:tekko/components/input_account.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({super.key});

  @override
  State<RegisterAccount> createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  void _goToLogin() => context.goNamed('login');

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  Future<void> _register() async {
    if (_isLoading) return;

    setState(() {
      _nameError =
          _nameController.text.isEmpty ? 'El nombre es obligatorio' : null;
      _emailError = _emailController.text.isEmpty
          ? 'El correo es obligatorio'
          : !_isValidEmail(_emailController.text)
              ? 'Correo inválido'
              : null;
      _passwordError = _passwordController.text.isEmpty
          ? 'La contraseña es obligatoria'
          : _passwordController.text.length < 6
              ? 'Debe tener al menos 6 caracteres'
              : null;
    });

    if (_nameError != null || _emailError != null || _passwordError != null)
      return;

    setState(() => _isLoading = true);

    try {
      final nameKid = await StorageUtils.getString('userName') ?? '';
      final ageKid = await StorageUtils.getInt('userAge') ?? 0;

      final authModel = AuthModel(
        fullNameParent: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        nameKid: nameKid,
        ageKid: ageKid,
      );

      context.read<AuthBloc>().add(RegisterRequested(authModel: authModel));
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<void> _registerWithGoogle() async {
    try {
      setState(() => _isLoading = true);

      const scopes = [
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile',
        'openid',
      ];
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId:
            '746910990367-lmf3ajat3u3lmmkh52bqfptub12luc09.apps.googleusercontent.com',
      );

      final googleUser = await googleSignIn.authenticate(scopeHint: scopes);

      final googleAuthentication = googleUser.authentication;

      final idToken = googleAuthentication.idToken;

      if (idToken == null) {
        throw Exception("Google no devolvió idToken");
      }

      context.read<AuthBloc>().add(
            RegisterWithGoogleRequested(idToken: idToken),
          );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          StorageUtils.setString('token', state.token);
          context.pushReplacement('/loading');
        } else if (state is AuthFailure) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.cardBackgroundSoft,
        body: Stack(
          children: [
            const CustomBackground(),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const _Header(),
                  const SizedBox(height: 60),
                  InputAccount(
                    hintText: "Nombre Completo",
                    inputController: _nameController,
                    isPass: false,
                    inputType: TextInputType.name,
                    errorText: _nameError,
                  ),
                  const SizedBox(height: 20),
                  InputAccount(
                    hintText: "Correo Electrónico",
                    inputController: _emailController,
                    isPass: false,
                    inputType: TextInputType.emailAddress,
                    errorText: _emailError,
                  ),
                  const SizedBox(height: 20),
                  InputAccount(
                    hintText: "Contraseña",
                    inputController: _passwordController,
                    isPass: true,
                    inputType: TextInputType.text,
                    errorText: _passwordError,
                  ),
                  const SizedBox(height: 40),
                  ButtonIntro(
                    onNext: _register,
                    textButton:
                        _isLoading ? 'Creando cuenta...' : 'Crear Cuenta',
                    isParent: true,
                  ),
                  const SizedBox(height: 15),
                  GoogleButton(
                    onPressed: _registerWithGoogle,
                    loading: _isLoading,
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: _goToLogin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.chocolateNewDark.withOpacity(0.1),
                      ),
                      child: const Text(
                        '¿Ya tienes una cuenta?  Inicia Sesión',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.chocolateDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/shibaIcon.png", width: 70),
        const SizedBox(height: 10),
        const Text(
          'TEKKO',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: AppColors.cardMaskSoft,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Crear Cuenta',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.softCreamDark,
          ),
        ),
      ],
    );
  }
}

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.4,
      child: Image.asset(
        'assets/images/topTitleAccount.png',
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
