import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/di/service_locator.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/storage/localstorage.dart';
import 'package:sayyor/core/storage/token_storage.dart';
import 'package:sayyor/core/themes/app_colors.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/widgets/app_async_state_view.dart';
import 'package:sayyor/features/profile/data/profile_mock_repository.dart';
import 'package:sayyor/features/profile/presentation/screen/my_orders_screen.dart';
import 'package:sayyor/features/profile/presentation/screen/payment_methods_screen.dart';
import 'package:sayyor/features/profile/presentation/screen/privacy_policy_screen.dart';
import 'package:sayyor/features/profile/presentation/screen/saved_masters_screen.dart';
import 'package:sayyor/features/profile/presentation/screen/support_center_screen.dart';
import 'package:sayyor/features/others/screen/selection_user.dart';
import 'package:sayyor/features/profile/presentation/bloc/locale/state.dart';
import 'package:sayyor/features/profile/presentation/bloc/theme/state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final bool _isMasterMode;
  bool _isAvailableForJobs = true;
  late Future<ProfileMockData> _profileFuture;
  String? _loadedLocaleKey;

  final ProfileMockRepository _repository = sl<ProfileMockRepository>();

  @override
  void initState() {
    super.initState();
    _isMasterMode = sl<LocalStorage>().userSelection == 'master';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localeKey = Localizations.localeOf(context).toLanguageTag();
    if (_loadedLocaleKey != localeKey) {
      _loadedLocaleKey = localeKey;
      _profileFuture = _repository.loadProfile(AppLocalizations.of(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;
    final currentLocale = context.watch<LocaleCubit>().state;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle, style: theme.textTheme.headlineSmall),
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
      body: FutureBuilder<ProfileMockData>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return AppAsyncStateView.loading(l10n);
          }

          if (snapshot.hasError) {
            return AppAsyncStateView.error(
              l10n: l10n,
              subtitle: l10n.stateErrorSubtitle,
              onRetry: () {
                setState(() {
                  _loadedLocaleKey = null;
                });
                didChangeDependencies();
              },
            );
          }

          final profile = snapshot.data;
          if (profile == null) {
            return AppAsyncStateView.empty(
              l10n: l10n,
              subtitle: l10n.stateEmptySubtitle,
            );
          }

          return SingleChildScrollView(
            padding: AppSizes.padding16,
            child: Column(
              children: [
                _buildProfileHeader(theme, l10n, profile),
                AppSizes.gH24,
                _buildMenuGroup(
                  theme: theme,
                  title: l10n.profileSectionMainTitle,
                  children: [
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.assignment_outlined,
                      title: l10n.profileOrdersTitle,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyOrdersScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(theme),
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.favorite_border_rounded,
                      title: l10n.profileSavedMastersTitle,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SavedMastersScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(theme),
                    // _buildMenuItem(
                    //   theme: theme,
                    //   icon: Icons.account_balance_wallet_outlined,
                    //   title: l10n.profilePaymentMethodsTitle,
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (_) => const PaymentMethodsScreen(),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
                AppSizes.gH24,
                _buildMenuGroup(
                  theme: theme,
                  title: l10n.profileSectionSettingsTitle,
                  children: [
                    if (_isMasterMode) ...[
                      _buildMenuItem(
                        theme: theme,
                        icon: Icons.work_outline_rounded,
                        title: l10n.profileAvailabilityTitle,
                        trailing: Switch(
                          value: _isAvailableForJobs,
                          activeThumbColor: theme.colorScheme.primary,
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
                      title: l10n.systemLanguage,
                      trailing: Text(
                        _languageLabel(l10n, currentLocale),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      onTap: () => _showLanguageSelector(context),
                    ),
                    _buildDivider(theme),
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.dark_mode_outlined,
                      title: l10n.profileThemeTitle,
                      trailing: Switch(
                        value: isDarkMode,
                        activeThumbColor: theme.colorScheme.primary,
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
                    ),
                  ],
                ),
                AppSizes.gH24,
                _buildMenuGroup(
                  theme: theme,
                  title: l10n.profileSectionAdditionalTitle,
                  children: [
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.help_outline_rounded,
                      title: l10n.profileSupportTitle,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SupportCenterScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(theme),
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.privacy_tip_outlined,
                      title: l10n.profilePrivacyTitle,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrivacyPolicyScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                AppSizes.gH24,
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: AppSizes.borderRadius16,
                    border: Border.all(
                      color: AppColors.kError.withValues(alpha: 0.3),
                    ),
                  ),
                  child: _buildMenuItem(
                    theme: theme,
                    icon: Icons.logout_rounded,
                    title: l10n.profileLogoutTitle,
                    iconColor: AppColors.kError,
                    textColor: AppColors.kError,
                    showArrow: false,
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      await sl<TokenStorage>().clear();
                      await sl<LocalStorage>().clearUserSelection();
                      if (!mounted) return;
                      navigator.pushAndRemoveUntil(
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
                  profile.version,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
                AppSizes.gH24,
              ],
            ),
          );
        },
      ),
    );
  }

  String _languageLabel(AppLocalizations l10n, Locale? locale) {
    switch (locale?.languageCode) {
      case 'en':
        return l10n.languageEnglish;
      case 'ru':
        return l10n.languageRussian;
      case 'uz':
        return l10n.languageUzbek;
      default:
        return l10n.languageSystem;
    }
  }

  void _showLanguageSelector(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeCubit = context.read<LocaleCubit>();
    final currentLocale = localeCubit.state;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        final sheetTheme = Theme.of(sheetContext);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: Text(l10n.languageSystem),
                trailing: currentLocale == null
                    ? Icon(Icons.check, color: sheetTheme.colorScheme.primary)
                    : null,
                onTap: () {
                  localeCubit.setLocale(null);
                  Navigator.pop(sheetContext);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(l10n.languageEnglish),
                trailing: currentLocale?.languageCode == 'en'
                    ? Icon(Icons.check, color: sheetTheme.colorScheme.primary)
                    : null,
                onTap: () {
                  localeCubit.setLocale(const Locale('en'));
                  Navigator.pop(sheetContext);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(l10n.languageRussian),
                trailing: currentLocale?.languageCode == 'ru'
                    ? Icon(Icons.check, color: sheetTheme.colorScheme.primary)
                    : null,
                onTap: () {
                  localeCubit.setLocale(const Locale('ru'));
                  Navigator.pop(sheetContext);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(l10n.languageUzbek),
                trailing: currentLocale?.languageCode == 'uz'
                    ? Icon(Icons.check, color: sheetTheme.colorScheme.primary)
                    : null,
                onTap: () {
                  localeCubit.setLocale(const Locale('uz'));
                  Navigator.pop(sheetContext);
                },
              ),
              AppSizes.gH16,
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(
    ThemeData theme,
    AppLocalizations l10n,
    ProfileMockData profile,
  ) {
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
                  image: DecorationImage(
                    image: NetworkImage(profile.avatarUrl),
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
          profile.name,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSizes.gH4,
        Text(
          profile.phone,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        AppSizes.gH16,
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.edit_outlined, size: 18.sp),
          label: Text(l10n.profileEditButton),
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
                color: theme.colorScheme.shadow.withValues(alpha: 0.03),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
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
                color: theme.colorScheme.outline.withValues(alpha: 0.5),
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
      color: theme.colorScheme.outline.withValues(alpha: 0.15),
    );
  }
}
