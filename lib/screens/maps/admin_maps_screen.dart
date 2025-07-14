import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:tekko/components/top_title_generic.dart';
import 'package:tekko/features/api/data/bloc/maps/map_bloc.dart';
import 'package:tekko/features/api/data/models/create_list_map_dto.dart';
import 'package:tekko/features/api/data/models/create_map_dto.dart';
import 'package:tekko/features/api/data/models/get_maps_dto.dart';
import 'package:tekko/features/api/data/models/update_map_dto.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/screens/accounts/map_dialog.dart';
import 'package:tekko/styles/app_colors.dart';

class AdminMapsScreen extends StatefulWidget {
  const AdminMapsScreen({super.key});

  @override
  State<AdminMapsScreen> createState() => _AdminMapsScreenState();
}

class _AdminMapsScreenState extends State<AdminMapsScreen> {
  late final MapController _mapController;
  String selectedType = 'Hogar';
  GetMapsDto? selectedMapInfo;

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

  Future<void> _openMapDialog() async {
    final hasPermission = await Geolocator.checkPermission();
    if (hasPermission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final confirmed = await showDialog<Position>(
      context: context,
      builder: (context) => MapDialog(initialPosition: position),
    );

    if (confirmed != null) {
      final token = await StorageUtils.getString('token');
      final newMap = CreateMapDto(
        typeMap: selectedType,
        latitude: confirmed.latitude,
        longitude: confirmed.longitude,
        token: token!,
      );

      final createListDto = CreateListMapDto(maps: [newMap]);
      context
          .read<MapBloc>()
          .add(MapCreatedRequested(createMapDto: createListDto));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ubicación guardada correctamente')),
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
      floatingActionButton: (context.read<MapBloc>().state
                  is MapGetInfoSuccess &&
              (context.read<MapBloc>().state as MapGetInfoSuccess)
                  .getMapInfo
                  .any((map) => map.typeMap == selectedType))
          ? FloatingActionButton(
              backgroundColor: AppColors.chocolateNewDark,
              onPressed: () async {
                final position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high,
                );

                final confirmed = await showDialog<Position>(
                  context: context,
                  builder: (context) => MapDialog(initialPosition: position),
                );

                if (confirmed != null) {
                  final token = await StorageUtils.getString('token');
                  final updatedMap = UpdateMapDto(
                    id: selectedMapInfo!.id,
                    typeMap: selectedMapInfo!.typeMap,
                    latitude: confirmed.latitude,
                    longitude: confirmed.longitude,
                    token: token!,
                  );

                  context
                      .read<MapBloc>()
                      .add(MapUpdateRequested(updateMapDto: updatedMap));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ubicación actualizada correctamente'),
                    ),
                  );
                }
              },
              child: const Icon(Icons.edit, color: Colors.white),
            )
          : null,
      body: Stack(children: [
        // Fondo decorativo animado
        Positioned(
          top: 0,
          child: Image.asset(
            'assets/images/topTitleAccount.png',
            width: size.width,
            fit: BoxFit.cover,
          ),
        ),

        Positioned.fill(
          child: Column(
            children: [
              const SizedBox(height: 20),
              FadeInRight(
                  duration: Duration(milliseconds: 600),
                  child: TopTitleGeneric(title: "Maps")),
              const SizedBox(height: 25),
              FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
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
                                  fontSize: 23,
                                  color: AppColors.chocolateNewDark),
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: typeOptions.map((type) {
                                    final isSelected = selectedType == type;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0),
                                      child: Column(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedType = type;

                                                // // // Obtenemos el primer mapa filtrado para esa categoría
                                                final newMap = context
                                                            .read<MapBloc>()
                                                            .state
                                                        is MapGetInfoSuccess
                                                    ? (context
                                                                .read<MapBloc>()
                                                                .state
                                                            as MapGetInfoSuccess)
                                                        .getMapInfo
                                                        .where((m) =>
                                                            m.typeMap == type)
                                                        .toList()
                                                    : [];

                                                if (newMap.isNotEmpty) {
                                                  final latLng = LatLng(
                                                      newMap[0].latitud,
                                                      newMap[0].longitude);
                                                  _mapController.move(latLng,
                                                      16.0); // Cambia la vista del mapa
                                                  selectedMapInfo = newMap[0];
                                                } else {
                                                  selectedMapInfo = null;
                                                }
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: isSelected
                                                  ? AppColors.chocolateNewDark
                                                  : AppColors.softCream,
                                              padding: const EdgeInsets.all(20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                                side: isSelected
                                                    ? const BorderSide(
                                                        color: AppColors
                                                            .chocolateNewDark,
                                                        width: 2,
                                                      )
                                                    : BorderSide.none,
                                              ),
                                            ),
                                            child: Image.asset(
                                                iconOptions[type]!,
                                                width: 39,
                                                height: 39),
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
                  )),

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
                        return Center(
                            child: FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: ElevatedButton(
                            onPressed: _openMapDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.chocolateNewDark,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Agregar ubicación',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ));
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
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedMapInfo = mapInfo;
                                  });
                                },
                                child: Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
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
                                          subdomains: const ['a', 'b', 'c'],
                                          userAgentPackageName: 'com.tekko.app',
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              point: latLng,
                                              width: 60,
                                              height: 60,
                                              child: const Icon(
                                                  Icons.location_pin,
                                                  color: Colors.red,
                                                  size: 40),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
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
            ],
          ),
        )
      ]),
    );
  }
}
