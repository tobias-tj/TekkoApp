import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/features/api/data/bloc/setting/setting_bloc.dart';
import 'package:tekko/features/api/data/models/details_profile_dto.dart';
import 'package:tekko/features/api/data/models/update_profile_dto.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class ProfileSummaryScreen extends StatefulWidget {
  final DetailsProfileDto profile;

  const ProfileSummaryScreen({super.key, required this.profile});

  @override
  State<ProfileSummaryScreen> createState() => _ProfileSummaryScreenState();
}

class _ProfileSummaryScreenState extends State<ProfileSummaryScreen> {
  late TextEditingController _parentNameController;
  late TextEditingController _childrenNameController;
  late TextEditingController _ageController;
  bool _isEditing = false;

  bool _isLoading = false;

  bool _hasChanges() {
    return _parentNameController.text != widget.profile.parentName ||
        _childrenNameController.text != widget.profile.childName ||
        _ageController.text != widget.profile.age.toString();
  }

  @override
  void initState() {
    super.initState();
    _parentNameController =
        TextEditingController(text: widget.profile.parentName)
          ..addListener(_onFieldChanged);
    _childrenNameController =
        TextEditingController(text: widget.profile.childName)
          ..addListener(_onFieldChanged);
    _ageController = TextEditingController(text: widget.profile.age.toString())
      ..addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _parentNameController.dispose();
    _childrenNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveChanges() async {
    if (_isLoading) return;
    try {
      final parentId = await StorageUtils.getInt('parentId') ?? 0;
      final childrenId = await StorageUtils.getInt('childrenId') ?? 0;

      final age = int.tryParse(_ageController.text);
      if (age == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor ingrese una edad válida'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() => _isLoading = true);

      final updateProfileData = UpdateProfileDto(
        parentId: parentId,
        childrenId: childrenId,
        nameParent: _parentNameController.text,
        nameChildren: _childrenNameController.text,
        age: age,
      );

      context.read<SettingBloc>().add(
            SettingUpdateProfileRequested(updateProfileDto: updateProfileData),
          );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocurrió un error inesperado al intentar guardar'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is SettingUpdateProfileSuccess) {
          setState(() => _isLoading = false);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Perfil actualizado con éxito'),
              backgroundColor: Colors.green,
            ),
          );

          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              context.goNamed('adminSettings');
            }
          });
        } else if (state is SettingError) {
          setState(() => _isLoading = false);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'No se pudo guardar los cambios. Por favor, intente nuevamente.'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.softCream,
        appBar: AppBar(
          backgroundColor: AppColors.softCream,
          elevation: 0,
          title: const Text(
            'Resumen del Perfil',
            style: TextStyle(
              color: AppColors.chocolateNewDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back, color: AppColors.chocolateNewDark),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              onPressed: _toggleEditing,
              icon: Icon(
                _isEditing ? Icons.close : Icons.edit,
                color: AppColors.chocolateNewDark,
              ),
              tooltip: _isEditing ? 'Cancelar edición' : 'Editar perfil',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isEditing
                  ? _buildEditableField(
                      'Nombre del Padre/Madre:', _parentNameController)
                  : _buildInfoTileWithIcon(Icons.person,
                      'Nombre del Padre/Madre:', widget.profile.parentName),
              _isEditing
                  ? _buildEditableField(
                      'Nombre del Niño/a:', _childrenNameController)
                  : _buildInfoTileWithIcon(Icons.child_care,
                      'Nombre del Niño/a:', widget.profile.childName),
              _buildInfoTileWithIcon(
                  Icons.email, 'Email:', widget.profile.email),
              _isEditing
                  ? _buildEditableField('Edad del Hijo/a:', _ageController,
                      isNumber: true)
                  : _buildInfoTileWithIcon(Icons.cake, 'Edad del Hijo/a:',
                      '${widget.profile.age} años'),
              const SizedBox(height: 8),
              _buildInfoTileWithIcon(Icons.create, 'Actividades creadas:',
                  '${widget.profile.totalActivitiesCreatedByParent}'),
              _buildInfoTileWithIcon(
                Icons.check_circle,
                'Actividades completadas:',
                '${widget.profile.totalCompletedActivitiesByChild}',
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              const SizedBox(height: 40),
              if (_isEditing)
                Expanded(
                  child: ElevatedButton(
                    onPressed: _hasChanges() ? _saveChanges : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.chocolateNewDark,
                    ),
                    child: Text(_isLoading ? 'Guardando...' : 'Guardar',
                        style: TextStyle(color: AppColors.textColor)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTileWithIcon(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: AppColors.chocolateNewDark),
        title: Text(
          label,
          style: const TextStyle(
            color: AppColors.chocolateNewDark,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        dense: true,
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.chocolateNewDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
