import 'package:sayyor/core/l10n/app_localizations.dart';

class SavedMasterData {
  final String id;
  final String name;
  final String avatarUrl;
  final String specialty;
  final double rating;
  final int completedJobs;
  final int experienceYears;
  final String startingPrice;
  final String location;
  final bool isAvailable;

  const SavedMasterData({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.specialty,
    required this.rating,
    required this.completedJobs,
    required this.experienceYears,
    required this.startingPrice,
    required this.location,
    required this.isAvailable,
  });
}

class SavedMastersMockRepository {
  Future<List<SavedMasterData>> loadSavedMasters(AppLocalizations l10n) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return <SavedMasterData>[
      SavedMasterData(
        id: 'master-1',
        name: 'Alisher Tursunov',
        avatarUrl: 'https://i.pravatar.cc/160?img=11',
        specialty: l10n.categoryPlumber,
        rating: 4.8,
        completedJobs: 126,
        experienceYears: 6,
        startingPrice: '120,000 so\'m',
        location: 'Yunusobod tumani',
        isAvailable: true,
      ),
      SavedMasterData(
        id: 'master-2',
        name: 'Sherzod Valiyev',
        avatarUrl: 'https://i.pravatar.cc/160?img=12',
        specialty: l10n.categoryElectrician,
        rating: 4.6,
        completedJobs: 98,
        experienceYears: 5,
        startingPrice: '150,000 so\'m',
        location: 'Chilonzor tumani',
        isAvailable: false,
      ),
      SavedMasterData(
        id: 'master-3',
        name: 'Jasur Rahmatov',
        avatarUrl: 'https://i.pravatar.cc/160?img=15',
        specialty: l10n.categoryFurniture,
        rating: 4.9,
        completedJobs: 173,
        experienceYears: 8,
        startingPrice: '180,000 so\'m',
        location: 'Mirzo Ulug\'bek tumani',
        isAvailable: true,
      ),
      SavedMasterData(
        id: 'master-4',
        name: 'Aziza Karimova',
        avatarUrl: 'https://i.pravatar.cc/160?img=25',
        specialty: l10n.categoryCleaning,
        rating: 4.7,
        completedJobs: 141,
        experienceYears: 7,
        startingPrice: '90,000 so\'m',
        location: 'Yakkasaroy tumani',
        isAvailable: true,
      ),
    ];
  }
}
