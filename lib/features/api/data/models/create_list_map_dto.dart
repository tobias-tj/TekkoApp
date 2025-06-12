import 'package:tekko/features/api/data/models/create_map_dto.dart';

class CreateListMapDto {
  final List<CreateMapDto> maps;

  CreateListMapDto({required this.maps});

  Map<String, dynamic> toJson() {
    return {
      'maps': maps.map((map) => map.toJson()).toList(),
    };
  }
}
