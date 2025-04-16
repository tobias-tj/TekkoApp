// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tekko/features/api/data/bloc/donation/donation_bloc.dart';
// import 'package:tekko/features/api/data/bloc/donation/donation_event.dart';
// import 'package:tekko/features/api/data/bloc/donation/donation_state.dart';

// class DonationFormScreen extends StatefulWidget {
//   final int amount;
//   final String currency;

//   const DonationFormScreen({
//     super.key,
//     required this.amount,
//     required this.currency,
//   });

//   @override
//   State<DonationFormScreen> createState() => _DonationFormScreenState();
// }

// class _DonationFormScreenState extends State<DonationFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _postalCodeController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _phoneController.dispose();
//     _nameController.dispose();
//     _addressController.dispose();
//     _cityController.dispose();
//     _postalCodeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Información de Donación'),
//       ),
//       body: BlocConsumer<DonationBloc, DonationState>(
//         listener: (context, state) {
//           if (state is PaymentConfirmed) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('¡Donación exitosa! Gracias por tu apoyo.'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//             Navigator.of(context).popUntil((route) => route.isFirst);
//           } else if (state is DonationError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Donación de \$${widget.amount} ${widget.currency}',
//                     style: Theme.of(context).textTheme.headlineSmall,
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: 'Correo Electrónico',
//                       prefixIcon: Icon(Icons.email),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Por favor ingrese su correo electrónico';
//                       }
//                       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                           .hasMatch(value)) {
//                         return 'Ingrese un correo electrónico válido';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 15),
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Nombre Completo (Opcional)',
//                       prefixIcon: Icon(Icons.person),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   TextFormField(
//                     controller: _phoneController,
//                     decoration: const InputDecoration(
//                       labelText: 'Teléfono (Opcional)',
//                       prefixIcon: Icon(Icons.phone),
//                     ),
//                     keyboardType: TextInputType.phone,
//                   ),
//                   const SizedBox(height: 15),
//                   TextFormField(
//                     controller: _addressController,
//                     decoration: const InputDecoration(
//                       labelText: 'Dirección (Opcional)',
//                       prefixIcon: Icon(Icons.home),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: TextFormField(
//                           controller: _cityController,
//                           decoration: const InputDecoration(
//                             labelText: 'Ciudad (Opcional)',
//                             prefixIcon: Icon(Icons.location_city),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: TextFormField(
//                           controller: _postalCodeController,
//                           decoration: const InputDecoration(
//                             labelText: 'Código Postal',
//                             prefixIcon: Icon(Icons.markunread_mailbox),
//                           ),
//                           keyboardType: TextInputType.number,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),
//                   if (state is DonationLoading)
//                     const Center(child: CircularProgressIndicator())
//                   else
//                     ElevatedButton(
//                       onPressed: () => _submitForm(context),
//                       child: const Text('Continuar con el Pago'),
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _submitForm(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       final bloc = context.read<DonationBloc>();

//       // Mostrar diálogo de confirmación
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Confirmar Donación'),
//           content: const Text('¿Estás seguro de proceder con esta donación?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancelar'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 // Obtener el clientSecret del estado actual
//                 final currentState = bloc.state;
//                 if (currentState is PaymentFormRequired) {
//                   bloc.add(ConfirmPaymentEvent(
//                     //TODO: Falta ver como le hago llegar el clientSecret o clientPublic porque no me acuerdo cual iba aqui
//                     clientSecret: 'currentState.clientSecret',
//                     email: _emailController.text,
//                     phone: _phoneController.text.isNotEmpty
//                         ? _phoneController.text
//                         : null,
//                     name: _nameController.text.isNotEmpty
//                         ? _nameController.text
//                         : null,
//                     addressLine1: _addressController.text.isNotEmpty
//                         ? _addressController.text
//                         : null,
//                     city: _cityController.text.isNotEmpty
//                         ? _cityController.text
//                         : null,
//                     postalCode: _postalCodeController.text.isNotEmpty
//                         ? _postalCodeController.text
//                         : null,
//                   ));
//                 }
//               },
//               child: const Text('Confirmar'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }
