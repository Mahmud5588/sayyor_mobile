import 'package:sayyor/core/l10n/app_localizations.dart';

class ProfileMockData {
  final String name;
  final String phone;
  final String avatarUrl;
  final String version;

  const ProfileMockData({
    required this.name,
    required this.phone,
    required this.avatarUrl,
    required this.version,
  });
}

class ProfileMockRepository {
  Future<ProfileMockData> loadProfile(AppLocalizations l10n) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));

    return ProfileMockData(
      name: 'Toshmat Eshmatov',
      phone: '+998 90 123 45 67',
      avatarUrl: 'https://i.pravatar.cc/300?img=32',
      version: '${l10n.profileVersionPrefix}1.0.0',
    );
  }
}
