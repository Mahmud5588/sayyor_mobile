import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sayyor/core/di/service_locator.dart';
import 'package:sayyor/core/storage/localstorage.dart';
import 'package:sayyor/core/storage/token_storage.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_colors.dart';
import 'package:sayyor/features/others/screen/selection_user.dart';
import 'package:sayyor/features/profile/presentation/bloc/theme/state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _currentLanguage = "O'zbekcha";
  late final bool _isMasterMode;
  bool _isAvailableForJobs = true;

  @override
  void initState() {
    super.initState();
    _isMasterMode = sl<LocalStorage>().userSelection == 'master';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil", style: theme.textTheme.headlineSmall),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSizes.padding16,
        child: Column(
          children: [
            _buildProfileHeader(theme),
            AppSizes.gH24,

            _buildMenuGroup(
              theme: theme,
              title: "Asosiy",
              children: [
                _buildMenuItem(
                  theme: theme,
                  icon: Icons.assignment_outlined,
                  title: "Mening buyurtmalarim",
                  onTap: () {},
                ),
                _buildDivider(theme),
                _buildMenuItem(
                  theme: theme,
                  icon: Icons.favorite_border_rounded,
                  title: "Saqlangan ustalar",
                  onTap: () {},
                ),
                _buildDivider(theme),
                _buildMenuItem(
                  theme: theme,
                  icon: Icons.account_balance_wallet_outlined,
                  title: "To'lov usullari",
                  onTap: () {},
                ),
              ],
            ),
            AppSizes.gH24,

            _buildMenuGroup(
              theme: theme,
              title: "Sozlamalar",
              children: [
                if (_isMasterMode) ...[
                  _buildMenuItem(
                    theme: theme,
                    icon: Icons.work_outline_rounded,
                    title: "Band holati",
                    trailing: Switch(
                      value: _isAvailableForJobs,
                      activeColor: theme.colorScheme.primary,
                      onChanged: (value) {
                        setState(() {
                          _isAvailableForJobs = value;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        _isAvailableForJobs = !_isAvailableForJobs;
                      });
                    },
                  ),
                  _buildDivider(theme),
                ],
                _buildMenuItem(
                  theme: theme,
                  icon: Icons.language,
                  title: "Tizim tili",
                  trailing: Text(
                    _currentLanguage,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  onTap: () {},
                ),
                _buildDivider(theme),
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return _buildMenuItem(
                      theme: theme,
                      icon: Icons.dark_mode_outlined,
                      title: "Tungi rejim",
                      trailing: Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          context.read<ThemeCubit>().setMode(
                            value ? ThemeMode.dark : ThemeMode.light,
                          );
                        },
                      ),
                      onTap: () {
                        final current = context.read<ThemeCubit>().state;
                        context.read<ThemeCubit>().setMode(
                          current == ThemeMode.dark
                              ? ThemeMode.light
                              : ThemeMode.dark,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            AppSizes.gH24,

            _buildMenuGroup(
              theme: theme,
              title: "Qo'shimcha",
              children: [
                _buildMenuItem(
                  theme: theme,
                  icon: Icons.help_outline_rounded,
                  title: "Qo'llab-quvvatlash markazi",
                  onTap: () {},
                ),
                _buildDivider(theme),
                _buildMenuItem(
                  theme: theme,
                  icon: Icons.privacy_tip_outlined,
                  title: "Maxfiylik siyosati va shartlar",
                  onTap: () {},
                ),
              ],
            ),
            AppSizes.gH24,

            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: AppSizes.borderRadius16,
                border: Border.all(color: AppColors.kError.withOpacity(0.3)),
              ),
              child: _buildMenuItem(
                theme: theme,
                icon: Icons.logout_rounded,
                title: "Tizimdan chiqish",
                iconColor: AppColors.kError,
                textColor: AppColors.kError,
                showArrow: false,

                onTap: () async {
                  await sl<TokenStorage>().clear();
                  await sl<LocalStorage>().clearUserSelection();
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RoleSelectionScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),

            AppSizes.gH32,

            Text(
              "Sayyor App v1.0.0",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            AppSizes.gH24,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                width: 100.w,
                height: 100.w,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 2.w,
                  ),
                  image: const DecorationImage(
                    image: NetworkImage("https:"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: AppSizes.padding4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.surface,
                      width: 2.w,
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: theme.colorScheme.onPrimary,
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSizes.gH16,

        Text(
          "Toshmat Eshmatov",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSizes.gH4,
        Text(
          "+998 90 123 45 67",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        AppSizes.gH16,

        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.edit_outlined, size: 18.sp),
          label: const Text("Profilni tahrirlash"),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primaryContainer,
            foregroundColor: theme.colorScheme.onPrimaryContainer,
            elevation: 0,
            minimumSize: Size(200.w, 45.h),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuGroup({
    required ThemeData theme,
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppSizes.w8, bottom: AppSizes.h8),
          child: Text(
            title.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.outline,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: AppSizes.borderRadius16,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.03),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
    Color? iconColor,
    Color? textColor,
    bool showArrow = true,
  }) {
    final effectiveIconColor = iconColor ?? theme.colorScheme.onSurfaceVariant;
    final effectiveTextColor = textColor ?? theme.colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      borderRadius: AppSizes.borderRadius16,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h16,
        ),
        child: Row(
          children: [
            Icon(icon, color: effectiveIconColor, size: 24.sp),
            AppSizes.gW16,
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: effectiveTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailing != null) trailing,
            if (trailing == null && showArrow)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: theme.colorScheme.outline.withOpacity(0.5),
                size: 16.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56.w,

      color: theme.colorScheme.outline.withOpacity(0.15),
    );
  }
}
