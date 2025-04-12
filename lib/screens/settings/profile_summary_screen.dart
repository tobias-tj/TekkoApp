import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
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
          title: FadeInRight(
            child: const Text(
              'Resumen del Perfil',
              style: TextStyle(
                color: AppColors.chocolateNewDark,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          leading: IconButton(
            icon: FadeInLeft(
              child: const Icon(Icons.arrow_back,
                  color: AppColors.chocolateNewDark, size: 28),
            ),
            onPressed: () => context.pop(),
          ),
          actions: [
            FadeInRight(
              child: IconButton(
                onPressed: _toggleEditing,
                icon: Icon(
                  _isEditing ? Icons.close : Icons.edit_note,
                  color: AppColors.chocolateNewDark,
                  size: 28,
                ),
                tooltip: _isEditing ? 'Cancelar edición' : 'Editar perfil',
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Sección de información personal
              FadeInUp(
                child: _buildSectionTitle('Información Personal'),
              ),
              const SizedBox(height: 8),

              // Nombre del padre/madre
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: _isEditing
                    ? _buildEditableCardField(
                        'Nombre del Padre/Madre', _parentNameController,
                        icon: HugeIcons.strokeRoundedUser)
                    : _buildInfoCardWithIcon(HugeIcons.strokeRoundedUser,
                        'Nombre del Padre/Madre', widget.profile.parentName),
              ),
              const SizedBox(height: 12),

              // Nombre del niño/a
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: _isEditing
                    ? _buildEditableCardField(
                        'Nombre del Niño/a', _childrenNameController,
                        icon: HugeIcons.strokeRoundedKid)
                    : _buildInfoCardWithIcon(HugeIcons.strokeRoundedKid,
                        'Nombre del Niño/a', widget.profile.childName),
              ),
              const SizedBox(height: 12),

              // Edad del niño/a
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: _isEditing
                    ? _buildEditableCardField('Edad del Niño/a', _ageController,
                        icon: HugeIcons.strokeRoundedArrangeByNumbers19,
                        isNumber: true)
                    : _buildInfoCardWithIcon(
                        HugeIcons.strokeRoundedArrangeByNumbers19,
                        'Edad del Niño/a',
                        '${widget.profile.age} años'),
              ),
              const SizedBox(height: 12),

              // Email (solo lectura)
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: _buildInfoCardWithIcon(
                    HugeIcons.strokeRoundedMailAccount01,
                    'Email',
                    widget.profile.email),
              ),
              const SizedBox(height: 20),

              // Sección de estadísticas
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: _buildSectionTitle('Estadísticas'),
              ),
              const SizedBox(height: 8),

              // Actividades creadas
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: _buildInfoCardWithIcon(
                    HugeIcons.strokeRoundedCheckList,
                    'Actividades Creadas',
                    '${widget.profile.totalActivitiesCreatedByParent}'),
              ),
              const SizedBox(height: 12),

              // Actividades completadas
              FadeInUp(
                delay: const Duration(milliseconds: 700),
                child: _buildInfoCardWithIcon(
                    HugeIcons.strokeRoundedCheckList,
                    'Actividades Completadas',
                    '${widget.profile.totalCompletedActivitiesByChild}'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _isEditing
            ? FadeInUp(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _hasChanges() ? _saveChanges : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.chocolateNewDark,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _isLoading ? 'Guardando...' : 'Guardar Cambios',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.chocolateNewDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCardWithIcon(IconData icon, String label, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: AppColors.chocolateNewDark,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableCardField(
    String label,
    TextEditingController controller, {
    required IconData icon,
    bool isNumber = false,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            HugeIcon(
              icon: icon,
              size: 28,
              color: AppColors.chocolateNewDark,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: controller,
                    keyboardType:
                        isNumber ? TextInputType.number : TextInputType.text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
