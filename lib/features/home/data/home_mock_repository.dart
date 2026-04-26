import 'package:sayyor/core/l10n/app_localizations.dart';

class HomePortfolioItemData {
  final String imageUrl;
  final String description;

  const HomePortfolioItemData({
    required this.imageUrl,
    required this.description,
  });
}

class HomeMasterData {
  final String id;
  final String name;
  final String avatarUrl;
  final String profession;
  final int age;
  final int experienceYears;
  final double rating;
  final int completedJobs;
  final String location;
  final String priceRange;
  final String about;
  final bool isBusy;
  final int reviewsCount;
  final List<HomePortfolioItemData> portfolio;

  const HomeMasterData({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.profession,
    required this.age,
    required this.experienceYears,
    required this.rating,
    required this.completedJobs,
    required this.location,
    required this.priceRange,
    required this.about,
    required this.isBusy,
    required this.reviewsCount,
    required this.portfolio,
  });
}

class HomeJobRequestData {
  final String userName;
  final String userAvatar;
  final String title;
  final String description;
  final String priceRange;
  final String timeAgo;
  final List<String> images;

  const HomeJobRequestData({
    required this.userName,
    required this.userAvatar,
    required this.title,
    required this.description,
    required this.priceRange,
    required this.timeAgo,
    required this.images,
  });
}

class HomeFeedData {
  final List<HomeMasterData> masters;
  final List<HomeJobRequestData> jobRequests;

  const HomeFeedData({required this.masters, required this.jobRequests});
}

class HomeMockRepository {
  Future<HomeFeedData> loadFeed(
    AppLocalizations l10n, {
    required bool isMasterMode,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return HomeFeedData(
      masters: <HomeMasterData>[
        HomeMasterData(
          id: 'm1',
          name: 'Alisher Tursunov',
          avatarUrl: 'https://i.pravatar.cc/150?img=11',
          profession: 'Santexnik',
          age: 31,
          experienceYears: 7,
          rating: 4.8,
          completedJobs: 183,
          reviewsCount: 124,
          location: 'Yunusobod tumani, 4-kvartal',
          priceRange: '150,000 - 450,000 so\'m',
          about: l10n.homeMasterAboutDescription,
          isBusy: true,
          portfolio: <HomePortfolioItemData>[
            HomePortfolioItemData(
              imageUrl: 'https://picsum.photos/seed/portfolio1/600/400',
              description: l10n.homeMasterPortfolioItemOneDescription,
            ),
            HomePortfolioItemData(
              imageUrl: 'https://picsum.photos/seed/portfolio2/600/400',
              description: l10n.homeMasterPortfolioItemTwoDescription,
            ),
          ],
        ),
        HomeMasterData(
          id: 'm2',
          name: 'Sherzod Valiyev',
          avatarUrl: 'https://i.pravatar.cc/150?img=12',
          profession: 'Elektrik',
          age: 29,
          experienceYears: 5,
          rating: 4.9,
          completedJobs: 148,
          reviewsCount: 98,
          location: 'Chilonzor tumani, 9-kvartal',
          priceRange: '120,000 - 350,000 so\'m',
          about: l10n.homeMasterAboutDescription,
          isBusy: false,
          portfolio: <HomePortfolioItemData>[
            HomePortfolioItemData(
              imageUrl: 'https://picsum.photos/seed/portfolio3/600/400',
              description: l10n.homeMasterPortfolioItemOneDescription,
            ),
          ],
        ),
        HomeMasterData(
          id: 'm3',
          name: 'Jasur Rahmatov',
          avatarUrl: 'https://i.pravatar.cc/150?img=15',
          profession: 'Tozalash',
          age: 34,
          experienceYears: 9,
          rating: 4.7,
          completedJobs: 97,
          reviewsCount: 67,
          location: 'Mirzo Ulug\'bek tumani',
          priceRange: '100,000 - 280,000 so\'m',
          about: l10n.homeMasterAboutDescription,
          isBusy: false,
          portfolio: <HomePortfolioItemData>[
            HomePortfolioItemData(
              imageUrl: 'https://picsum.photos/seed/portfolio4/600/400',
              description: l10n.homeMasterPortfolioItemTwoDescription,
            ),
          ],
        ),
      ],
      jobRequests: <HomeJobRequestData>[
        HomeJobRequestData(
          userName: 'Javlonbek',
          userAvatar: 'https://i.pravatar.cc/150?img=21',
          title: l10n.homeJobRequestOneTitle,
          description: l10n.homeJobRequestOneDescription,
          priceRange: '120,000 - 180,000 so\'m',
          timeAgo: l10n.homeJobRequestOneTimeAgo,
          images: <String>[
            'https://picsum.photos/seed/job1/300/200',
            'https://picsum.photos/seed/job2/300/200',
          ],
        ),
        HomeJobRequestData(
          userName: 'Mubina',
          userAvatar: 'https://i.pravatar.cc/150?img=23',
          title: l10n.homeJobRequestTwoTitle,
          description: l10n.homeJobRequestTwoDescription,
          priceRange: '90,000 - 140,000 so\'m',
          timeAgo: l10n.homeJobRequestTwoTimeAgo,
          images: <String>['https://picsum.photos/seed/job3/300/200'],
        ),
      ],
    );
  }
}
