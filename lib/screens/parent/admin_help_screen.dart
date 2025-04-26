import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tekko/components/donation/build_dialog_info_item.dart';
import 'package:tekko/components/donation/build_info_item.dart';
import 'package:tekko/features/api/data/bloc/donation/donation_bloc.dart';
import 'package:tekko/features/api/data/bloc/donation/donation_event.dart';
import 'package:tekko/features/api/data/bloc/donation/donation_state.dart';
import 'package:tekko/features/api/data/bloc/setting/setting_bloc.dart';
import 'package:tekko/features/api/data/models/donation.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart' as material;

class AdminHelpScreen extends StatefulWidget {
  const AdminHelpScreen({super.key});

  @override
  State<AdminHelpScreen> createState() => _AdminHelpScreenState();
}

class _AdminHelpScreenState extends State<AdminHelpScreen> {
  final List<Map<String, dynamic>> _donationOptions = [
    {'amount': 5, 'icon': HugeIcons.strokeRoundedCoins01},
    {'amount': 10, 'icon': HugeIcons.strokeRoundedMoneyAdd01},
    {'amount': 20, 'icon': HugeIcons.strokeRoundedMoneyBag01},
    {'amount': 50, 'icon': HugeIcons.strokeRoundedMoney03},
  ];

  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();

    // Suscribirse al bloc para guardar los datos
    final settingState = context.read<SettingBloc>().state;
    if (settingState is SettingProfileSuccess) {
      userName = settingState.detailsProfileDto.parentName;
      userEmail = settingState.detailsProfileDto.email;
    }
  }

  Future<void> _processDonation(int amount) async {
    final token = await StorageUtils.getString('token');
    context.read<DonationBloc>().add(
          StartDonationEvent(Donation(
              token: token!,
              amount: amount,
              fullName: userName ?? 'Nombre Vacio',
              email: userEmail!)),
        );
  }

  void _showDonationDialog(int amount) {
    showDialog(
      context: context,
      builder: (context) => FadeInUp(
        child: AlertDialog(
          backgroundColor: AppColors.cardBackgroundSoft,
          title: const Text(
            "Confirmar Donación",
            style: TextStyle(
                color: AppColors.textColor, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Estás a punto de donar:"),
              const SizedBox(height: 10),
              Text(
                "\$$amount USD",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.chocolateNewDark,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Gracias por apoyar a Tekko y a la fundación EPA. "
                "Tu contribución nos ayuda a:",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              BuildDialogInfoItem(text: "Mantener los servidores activos"),
              BuildDialogInfoItem(text: "Desarrollar nuevas funcionalidades"),
              BuildDialogInfoItem(text: "Apoyar a la fundación EPA (10%)"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: AppColors.chocolateNewDark),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.chocolateNewDark,
              ),
              onPressed: () {
                Navigator.pop(context);
                _processDonation(amount * 100);
              },
              child: const Text(
                "Confirmar Donación",
                style: TextStyle(
                    color: AppColors.textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThankYouMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            "¡Gracias por tu donación! Tu apoyo es invaluable para nosotros."),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showPaymentError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $message"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _launchEPASite() async {
    const url = 'https://autismo.com.py/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showPaymentError('No se pudo abrir el enlace');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<DonationBloc, DonationState>(
      listener: (context, state) async {
        if (state is DonationClientSecretReady) {
          await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: state.clientSecret,
                merchantDisplayName: 'Tekko',
                billingDetails: BillingDetails(
                  email: "Raulnose@gmail.com",
                  name: 'Raul Salcedo',
                )),
          );
          await Stripe.instance.presentPaymentSheet();
          _showThankYouMessage();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.softCream,
        body: Stack(
          children: [
            // Fondo decorativo animado
            Positioned(
              top: 0,
              child: FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: Image.asset(
                  'assets/images/topTitleAccount.png',
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Contenido principal
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  // Encabezado con animación
                  FadeIn(
                    duration: const Duration(milliseconds: 1000),
                    child: Center(
                      child: SizedBox(
                        height: 200,
                        child: Lottie.asset(
                          "assets/animations/dogHome1.json",
                          repeat: true,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tarjeta de información
                  FadeInLeft(
                    duration: const Duration(milliseconds: 600),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: material.Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Text(
                                "Apoya a Tekko",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.chocolateNewDark,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Tekko es un proyecto sin fines de lucro. Cada donación nos ayuda a:",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 15),
                              BuildInfoItem(
                                icon: HugeIcons.strokeRoundedCloudServer,
                                text: "Mantener los servidores activos",
                              ),
                              BuildInfoItem(
                                icon: HugeIcons.strokeRoundedCode,
                                text: "Desarrollar nuevas funcionalidades",
                              ),
                              BuildInfoItem(
                                icon: HugeIcons.strokeRoundedHeartCheck,
                                text: "Apoyar a la fundación EPA",
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Además, el 10% de cada donación va directamente a la fundación "
                                "'Esperanza para el Autismo (EPA)' para apoyar su labor.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 10),
                              FadeInUp(
                                child: InkWell(
                                  onTap: _launchEPASite,
                                  child: const Text(
                                    "Conoce más sobre EPA",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Opciones de donación
                  FadeInRight(
                    duration: const Duration(milliseconds: 600),
                    child: const Text(
                      "Selecciona un monto para donar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.chocolateNewDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Grid de opciones de donación con animaciones escalonadas
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: List.generate(_donationOptions.length, (index) {
                        final option = _donationOptions[index];
                        return FadeInUp(
                          duration: Duration(milliseconds: 600 + (index * 100)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.cardBackgroundSoft,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                            ),
                            onPressed: () =>
                                _showDonationDialog(option['amount']),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HugeIcon(
                                  icon: option['icon'],
                                  color: AppColors.chocolateNewDark,
                                  size: 30,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "\$${option['amount']}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.chocolateNewDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // Opción de monto personalizado
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton.icon(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedPencilEdit02,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: const Text(
                          "Otro monto",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.chocolateNewDark,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Colors.black.withOpacity(0.2),
                          elevation: 5,
                        ),
                        onPressed: () => _showCustomAmountDialog(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomAmountDialog() {
    final TextEditingController _amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => FadeInUp(
        child: AlertDialog(
          backgroundColor: AppColors.cardBackgroundSoft,
          title: const Text(
            "Donación Personalizada",
            style: TextStyle(
                color: AppColors.textColor, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Monto en USD",
                  prefixText: "\$",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Ingresa el monto que deseas donar. Recuerda que el 10% irá a la fundación EPA.",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: AppColors.chocolateNewDark),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.chocolateNewDark,
              ),
              onPressed: () {
                final enteredAmount = int.tryParse(_amountController.text);
                if (enteredAmount != null && enteredAmount > 0) {
                  Navigator.pop(context); // cerrar diálogo
                  _showDonationDialog(enteredAmount); // mostrar confirmación
                } else {
                  _showPaymentError("Por favor ingresa un monto válido");
                }
              },
              child: const Text(
                "Continuar",
                style: TextStyle(
                    color: AppColors.textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
