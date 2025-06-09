import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/features/api/data/bloc/maps/map_bloc.dart';
import 'package:tekko/features/api/data/models/create_list_map_dto.dart';
import 'package:tekko/features/api/data/models/create_map_dto.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/screens/accounts/map_dialog.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class MapsAccountScreen extends StatefulWidget {
  const MapsAccountScreen({super.key});

  @override
  State<MapsAccountScreen> createState() => _MapsAccountScreenState();
}

class _MapsAccountScreenState extends State<MapsAccountScreen> {
  final List<String> _locations = [
    'Hogar',
    'Trabajo Papá',
    'Trabajo Mamá',
    'Escuela',
  ];

  Map<String, Position?> _selectedLocations = {};
  bool _isLoading = false;

  Future<void> _selectLocation(String label) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Permiso de ubicación denegado permanentemente')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 10),
      );

      final confirmed = await showDialog<Position>(
        context: context,
        builder: (context) => MapDialog(initialPosition: position),
      );

      if (confirmed != null) {
        setState(() {
          _selectedLocations[label] = confirmed;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error obteniendo ubicación: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _submit() async {
    final token = await StorageUtils.getString('token');

    if (!_selectedLocations.containsKey('Hogar') ||
        _selectedLocations['Hogar'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Debes registrar al menos la ubicación del Hogar')),
      );
      return;
    }

    // print('Ubicaciones seleccionadas: $_selectedLocations');

    final List<CreateMapDto> maps = _selectedLocations.entries
        .where((entry) => entry.value != null)
        .map((entry) => CreateMapDto(
              typeMap: entry.key,
              latitude: entry.value!.latitude,
              longitude: entry.value!.longitude,
              token: token!,
            ))
        .toList();

    final createListDto = CreateListMapDto(maps: maps);

    context
        .read<MapBloc>()
        .add(MapCreatedRequested(createMapDto: createListDto));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Se ha agregado correctamente las ubicaciones')),
    );

    Future.delayed(const Duration(milliseconds: 3000), () {
      context.pushReplacement('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.cardBackgroundSoft,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.1),
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Estas ubicaciones ayudarán a establecer puntos de referencia importantes para tu hijo/a, como dónde vive, estudia o están sus familiares. \n\n*La ubicación del Hogar es obligatoria.',
                        style: const TextStyle(
                          color: AppColors.chocolateDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Column(
                  children: [
                    ..._locations.asMap().entries.map((entry) {
                      final i = entry.key;
                      final loc = entry.value;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        child: FadeInLeft(
                          delay: Duration(milliseconds: 200 * i),
                          child: ElevatedButton(
                            onPressed:
                                _isLoading ? null : () => _selectLocation(loc),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.cardMaskSoft,
                              padding: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  loc,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                _selectedLocations[loc] != null
                                    ? const Icon(Icons.check_circle,
                                        color: Colors.green)
                                    : const Icon(Icons.location_off,
                                        color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 30),
                    FadeInUp(
                      delay: const Duration(milliseconds: 500),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.chocolateNewDark,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          _isLoading ? 'Guardando...' : 'Guardar y continuar',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
