import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/di/service_locator.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/storage/localstorage.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/features/authentification/presentation/screen/login.dart';

// Rolni aniqlash uchun Enum
enum UserRole { none, client, master }

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  UserRole _selectedRole = UserRole.none;
  final LocalStorage _localStorage = sl<LocalStorage>();

  @override
  void initState() {
    super.initState();
    _loadSavedSelection();
  }

  void _loadSavedSelection() {
    final savedSelection = _localStorage.userSelection;
    if (savedSelection == null || savedSelection.isEmpty) {
      return;
    }

    final role = UserRole.values.firstWhere(
      (item) => item.name == savedSelection,
      orElse: () => UserRole.none,
    );

    if (role != UserRole.none) {
      setState(() {
        _selectedRole = role;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Orqaga qaytish tugmasi kerak bo'lsa
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSizes.padding24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. SARLAVHA VA TAVSIF
              Text(
                l10n.roleSelectionTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              AppSizes.gH12,
              Text(
                l10n.roleSelectionSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                  height: 1.5,
                ),
              ),
              AppSizes.gH32,

              // 2. MIJOZ (CLIENT) ROLI UCHUN KARTA
              _buildRoleCard(
                theme: theme,
                role: UserRole.client,
                title: l10n.roleClientTitle,
                description: l10n.roleClientDescription,
                icon: Icons.person_search_outlined,
              ),
              AppSizes.gH16,

              // 3. USTA (MASTER) ROLI UCHUN KARTA
              _buildRoleCard(
                theme: theme,
                role: UserRole.master,
                title: l10n.roleMasterTitle,
                description: l10n.roleMasterDescription,
                icon: Icons.handyman_outlined,
              ),

              const Spacer(),

              // 4. DAVOM ETISH TUGMASI
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedRole == UserRole.none
                      ? null // Agar rol tanlanmagan bo'lsa, tugma ishlamaydi (disabled)
                      : () async {
                          final navigator = Navigator.of(context);
                          await _localStorage.setUserSelection(
                            _selectedRole.name,
                          );
                          if (!mounted) return;
                          navigator.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                  child: Text(l10n.continueButton),
                ),
              ),
              AppSizes.gH16,
            ],
          ),
        ),
      ),
    );
  }

  // --- ROL KARTASINI QURUVCHI WIDGET (Helper) ---
  Widget _buildRoleCard({
    required ThemeData theme,
    required UserRole role,
    required String title,
    required String description,
    required IconData icon,
  }) {
    final isSelected = _selectedRole == role;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      borderRadius: AppSizes.borderRadius16,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: AppSizes.padding20,
        decoration: BoxDecoration(
          // Tanlangan bo'lsa apelsin fon, aks holda standart fon
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: AppSizes.borderRadius16,
          border: Border.all(
            // Tanlangan bo'lsa qalinroq va apelsin chiziq
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withValues(alpha: 0.2),
            width: isSelected ? 2.w : 1.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.15),
                    blurRadius: 15.r,
                    offset: Offset(0, 8.h),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Ikonka qismi
            Container(
              padding: AppSizes.padding12,
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
                size: 28.sp,
              ),
            ),
            AppSizes.gW16,

            // Matnlar qismi
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  AppSizes.gH4,
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.outline,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // O'ng tomondagi tanlanganlik belgisi (Check icon)
            if (isSelected) ...[
              AppSizes.gW12,
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: 24.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
