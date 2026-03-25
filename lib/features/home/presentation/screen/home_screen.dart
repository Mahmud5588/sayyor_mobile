import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/features/chat/presentation/screen/chat_detail_screen.dart';
import 'package:sayyor/features/home/presentation/widget/master_detail.dart';
import 'package:sayyor/features/posts/presentation/screen/job_request_card.dart';
import 'package:sayyor/features/posts/presentation/screen/job_request_detail.dart';

import '../../../../core/themes/app_sizes.dart';
import '../widget/master_card_widget.dart';

class HomeScreen extends StatefulWidget {
  final bool isMasterMode;

  const HomeScreen({super.key, this.isMasterMode = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _categories = [
    "Barchasi",
    "Santexnik",
    "Elektrik",
    "Tozalash",
    "Mebel ustasi",
  ];
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _masters = [
    {
      'id': 'm1',
      'name': 'Alisher Tursunov',
      'profession': 'Santexnik',
      'location': 'Yunusobod tumani, 4-kvartal',
      'priceRange': '150,000 - 450,000 so\'m',
      'rating': 4.8,
      'reviews': 124,
      'isBusy': true,
      'avatar': 'https://i.pravatar.cc/150?img=11',
    },
    {
      'id': 'm2',
      'name': 'Sherzod Valiyev',
      'profession': 'Elektrik',
      'location': 'Chilonzor tumani, 9-kvartal',
      'priceRange': '120,000 - 350,000 so\'m',
      'rating': 4.9,
      'reviews': 98,
      'isBusy': false,
      'avatar': 'https://i.pravatar.cc/150?img=12',
    },
    {
      'id': 'm3',
      'name': 'Jasur Rahmatov',
      'profession': 'Tozalash',
      'location': 'Mirzo Ulug\'bek tumani',
      'priceRange': '100,000 - 280,000 so\'m',
      'rating': 4.7,
      'reviews': 67,
      'isBusy': false,
      'avatar': 'https://i.pravatar.cc/150?img=15',
    },
  ];

  final List<Map<String, dynamic>> _jobRequests = [
    {
      'userName': 'Javlonbek',
      'userAvatar': 'https://i.pravatar.cc/150?img=21',
      'title': 'Kranni almashtirish kerak',
      'description':
          'Oshxonadagi kran nosoz, suv tomchilab oqyapti. Yangi kran bor, o\'rnatib berish kerak.',
      'priceRange': '120,000 - 180,000 so\'m',
      'timeAgo': '12 daqiqa oldin',
      'images': [
        'https://picsum.photos/seed/job1/300/200',
        'https://picsum.photos/seed/job2/300/200',
      ],
    },
    {
      'userName': 'Mubina',
      'userAvatar': 'https://i.pravatar.cc/150?img=23',
      'title': 'Rozetka ishlamayapti',
      'description':
          'Mehmonxonadagi 2 ta rozetka tok bermayapti. Iloji bo\'lsa bugun kelib ko\'rib bering.',
      'priceRange': '90,000 - 140,000 so\'m',
      'timeAgo': '37 daqiqa oldin',
      'images': ['https://picsum.photos/seed/job3/300/200'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: widget.isMasterMode
            ? Text("Ish so'rovlari", style: theme.textTheme.titleLarge)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("Tashkent", style: theme.textTheme.titleMedium),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.keyboard_arrow_down),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
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
      body: widget.isMasterMode
          ? _buildMasterHome(theme)
          : _buildUserHome(theme),
    );
  }

  Widget _buildUserHome(ThemeData theme) {
    return Column(
      children: [
        Padding(
          padding: AppSizes.paddingH16.add(AppSizes.paddingV8),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Usta yoki xizmat qidiring...",
              hintStyle: theme.textTheme.bodyMedium,
              prefixIcon: Icon(Icons.search, color: theme.colorScheme.outline),
              filled: true,
              fillColor:
                  theme.colorScheme.surfaceVariant?.withOpacity(0.5) ??
                  Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: AppSizes.borderRadius16,
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        SizedBox(
          height: AppSizes.h56,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: AppSizes.paddingH16,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedCategoryIndex == index;
              return Padding(
                padding: EdgeInsets.only(right: AppSizes.w8),
                child: ChoiceChip(
                  label: Text(_categories[index]),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  selectedColor: theme.colorScheme.primary,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              );
            },
          ),
        ),
        AppSizes.gH8,
        Expanded(
          child: ListView.builder(
            itemCount: _masters.length,
            itemBuilder: (context, index) {
              final item = _masters[index];
              return MasterCardWidget(
                imageUrl: item['avatar'] as String,
                name: item['name'] as String,
                profession: item['profession'] as String,
                location: item['location'] as String,
                rating: item['rating'] as double,
                reviewsCount: item['reviews'] as int,
                priceRange: item['priceRange'] as String,
                isBusy: item['isBusy'] as bool,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MasterDetailScreen(
                        master: MasterDetailModel(
                          id: item['id'] as String,
                          name: item['name'] as String,
                          avatarUrl: item['avatar'] as String,
                          profession: item['profession'] as String,
                          age: 31,
                          experienceYears: 7,
                          rating: item['rating'] as double,
                          completedJobs: 183,
                          location: item['location'] as String,
                          priceRange: item['priceRange'] as String,
                          about:
                              "Uy, ofis va tijorat obyektlarida sifatli xizmat ko'rsatadi.",
                          portfolio: [
                            PortfolioItem(
                              imageUrl:
                                  'https://picsum.photos/seed/portfolio1/600/400',
                              description:
                                  "Sanuzel quvurlari to'liq yangilandi.",
                            ),
                            PortfolioItem(
                              imageUrl:
                                  'https://picsum.photos/seed/portfolio2/600/400',
                              description:
                                  "Elektr qalqon modernizatsiyasi bajarildi.",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                onChatTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailScreen(
                        masterName: item['name'] as String,
                        imageUrl: item['avatar'] as String,
                        isNewChat: true,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMasterHome(ThemeData theme) {
    return ListView.builder(
      padding: AppSizes.paddingV8,
      itemCount: _jobRequests.length,
      itemBuilder: (context, index) {
        final item = _jobRequests[index];
        return JobRequestCard(
          userName: item['userName'] as String,
          userAvatar: item['userAvatar'] as String,
          title: item['title'] as String,
          description: item['description'] as String,
          priceRange: item['priceRange'] as String,
          timeAgo: item['timeAgo'] as String,
          images: item['images'] as List<String>,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JobRequestDetailScreen(
                  userName: item['userName'] as String,
                  userAvatar: item['userAvatar'] as String,
                  title: item['title'] as String,
                  description: item['description'] as String,
                  priceRange: item['priceRange'] as String,
                  images: item['images'] as List<String>,
                ),
              ),
            );
          },
          onBidTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JobRequestDetailScreen(
                  userName: item['userName'] as String,
                  userAvatar: item['userAvatar'] as String,
                  title: item['title'] as String,
                  description: item['description'] as String,
                  priceRange: item['priceRange'] as String,
                  images: item['images'] as List<String>,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
