import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:latlong2/latlong.dart';
import 'package:tekko/features/api/data/bloc/maps/map_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late final MapController _mapController;
  String selectedType = 'Hogar';

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getMapsData();
  }

  Future<void> _getMapsData() async {
    try {
      final token = await StorageUtils.getString('token');
      if (token != null) {
        context.read<MapBloc>().add(MapGetRequested(token: token));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> typeOptions = [
      'Hogar',
      'Trabajo Papá',
      'Trabajo Mamá',
      'Escuela'
    ];

    final Map<String, String> iconOptions = {
      'Hogar': 'assets/images/family-hd.png',
      'Trabajo Papá': 'assets/images/words/familia/dadIcon.png',
      'Trabajo Mamá': 'assets/images/words/familia/momIcon.png',
      'Escuela': 'assets/images/words/escuela/aulaIcon.png',
    };

    return Scaffold(
        backgroundColor: AppColors.softCream,
        body: Column(
          children: [
            // Cabecera
            Container(
              width: double.infinity,
              height: size.height * 0.2,
              color: AppColors.chocolateNewDark,
              alignment: Alignment.center,
              child: const Text(
                "Mapas",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.softCreamDark,
                ),
              ),
            ),

            Card(
              color: AppColors.softCreamDark,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selecciona la direccion',
                      style: TextStyle(
                          fontSize: 23, color: AppColors.chocolateNewDark),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: typeOptions.map((type) {
                            final isSelected = selectedType == type;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedType = type;

                                        // Obtenemos el primer mapa filtrado para esa categoría
                                        final newMap = context
                                                .read<MapBloc>()
                                                .state is MapGetInfoSuccess
                                            ? (context.read<MapBloc>().state
                                                    as MapGetInfoSuccess)
                                                .getMapInfo
                                                .where((m) => m.typeMap == type)
                                                .toList()
                                            : [];

                                        if (newMap.isNotEmpty) {
                                          final latLng = LatLng(
                                              newMap[0].latitud,
                                              newMap[0].longitude);
                                          _mapController.move(latLng,
                                              16.0); // Cambia la vista del mapa
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isSelected
                                          ? AppColors.chocolateNewDark
                                          : AppColors.softCream,
                                      padding: const EdgeInsets.all(20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(22),
                                        side: isSelected
                                            ? const BorderSide(
                                                color:
                                                    AppColors.chocolateNewDark,
                                                width: 2,
                                              )
                                            : BorderSide.none,
                                      ),
                                    ),
                                    child: Image.asset(iconOptions[type]!,
                                        width: 39, height: 39),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    type,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ))
                  ],
                ),
              ),
            ),

            // Lista de mapas
            Expanded(
              child: BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  if (state is MapGetInfoSuccess) {
                    if (state.getMapInfo.isEmpty) {
                      return const Center(
                          child: Text('No hay Mapas guardados'));
                    }
                    final filteredMaps = state.getMapInfo
                        .where((map) => map.typeMap == selectedType)
                        .toList();

                    if (filteredMaps.isEmpty) {
                      return const Center(
                          child: Text('No hay mapas para esta categoría.'));
                    }
                    return ListView.builder(
                      itemCount: filteredMaps.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        final mapInfo = filteredMaps[index];
                        final latLng =
                            LatLng(mapInfo.latitud, mapInfo.longitude);
                        return SizedBox(
                          height: size.height * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: FlutterMap(
                                  mapController: _mapController,
                                  options: MapOptions(
                                    initialCenter: latLng,
                                    initialZoom: 16.0,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=N1UuPpbGdpT4O1xEFQB1",
                                      tileProvider: NetworkTileProvider(),
                                      userAgentPackageName: 'com.tekko.app',
                                    ),
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          point: latLng,
                                          width: 60,
                                          height: 60,
                                          child: const Icon(Icons.location_pin,
                                              color: Colors.red, size: 40),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    );
                  } else if (state is MapLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MapError) {
                    return const Center(child: Text('Error cargando Mapas'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Bounce(
              infinite: false,
              child: ElevatedButton(
                onPressed: () {
                  final state = context.read<MapBloc>().state;
                  if (state is MapGetInfoSuccess) {
                    final filteredMaps = state.getMapInfo
                        .where((map) => map.typeMap == selectedType)
                        .toList();

                    if (filteredMaps.isNotEmpty) {
                      final mapInfo = filteredMaps.first;
                      context.push(
                        '/qrMaps',
                        extra: {
                          'lat': mapInfo.latitud,
                          'lng': mapInfo.longitude
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('No hay ubicación para compartir')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.chocolateNewDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  elevation: 8,
                  shadowColor: Colors.orange.withOpacity(0.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Compartir",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 15),
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedShare05,
                      color: AppColors.textColor,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ));
  }
}
