import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/di/service_locator.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/widgets/app_async_state_view.dart';
import 'package:sayyor/features/home/data/home_mock_repository.dart';
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
  int _selectedCategoryIndex = 0;
  late Future<HomeFeedData> _feedFuture;
  String? _loadedLocaleKey;

  final HomeMockRepository _repository = sl<HomeMockRepository>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localeKey = Localizations.localeOf(context).toLanguageTag();
    if (_loadedLocaleKey != localeKey) {
      _loadedLocaleKey = localeKey;
      _feedFuture = _repository.loadFeed(
        AppLocalizations.of(context),
        isMasterMode: widget.isMasterMode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final categories = _localizedCategories(l10n);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: widget.isMasterMode
            ? Text(l10n.homeRequestsTitle, style: theme.textTheme.titleLarge)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(l10n.homeCityName, style: theme.textTheme.titleMedium),
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
      body: FutureBuilder<HomeFeedData>(
        future: _feedFuture,
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

          final data = snapshot.data;
          if (data == null) {
            return AppAsyncStateView.empty(
              l10n: l10n,
              subtitle: l10n.stateEmptySubtitle,
            );
          }

          return widget.isMasterMode
              ? _buildMasterHome(theme, l10n, data)
              : _buildUserHome(theme, l10n, categories, data);
        },
      ),
    );
  }

  Widget _buildUserHome(
    ThemeData theme,
    AppLocalizations l10n,
    List<String> categories,
    HomeFeedData data,
  ) {
    if (data.masters.isEmpty) {
      return AppAsyncStateView.empty(
        l10n: l10n,
        subtitle: l10n.stateEmptySubtitle,
      );
    }

    return Column(
      children: [
        Padding(
          padding: AppSizes.paddingH16.add(AppSizes.paddingV8),
          child: TextField(
            decoration: InputDecoration(
              hintText: l10n.homeSearchHint,
              hintStyle: theme.textTheme.bodyMedium,
              prefixIcon: Icon(Icons.search, color: theme.colorScheme.outline),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
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
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedCategoryIndex == index;
              return Padding(
                padding: EdgeInsets.only(right: AppSizes.w8),
                child: ChoiceChip(
                  label: Text(categories[index]),
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
            itemCount: data.masters.length,
            itemBuilder: (context, index) {
              final item = data.masters[index];
              return MasterCardWidget(
                imageUrl: item.avatarUrl,
                name: item.name,
                profession: item.profession,
                location: item.location,
                rating: item.rating,
                reviewsCount: item.reviewsCount,
                priceRange: item.priceRange,
                isBusy: item.isBusy,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MasterDetailScreen(
                        master: MasterDetailModel(
                          id: item.id,
                          name: item.name,
                          avatarUrl: item.avatarUrl,
                          profession: item.profession,
                          age: item.age,
                          experienceYears: item.experienceYears,
                          rating: item.rating,
                          completedJobs: item.completedJobs,
                          location: item.location,
                          priceRange: item.priceRange,
                          about: item.about,
                          portfolio: item.portfolio
                              .map(
                                (portfolioItem) => PortfolioItem(
                                  imageUrl: portfolioItem.imageUrl,
                                  description: portfolioItem.description,
                                ),
                              )
                              .toList(),
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
                        masterName: item.name,
                        imageUrl: item.avatarUrl,
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

  List<String> _localizedCategories(AppLocalizations l10n) => [
    l10n.categoryAll,
    l10n.categoryPlumber,
    l10n.categoryElectrician,
    l10n.categoryCleaning,
    l10n.categoryFurniture,
  ];

  Widget _buildMasterHome(
    ThemeData theme,
    AppLocalizations l10n,
    HomeFeedData data,
  ) {
    if (data.jobRequests.isEmpty) {
      return AppAsyncStateView.empty(
        l10n: l10n,
        subtitle: l10n.stateEmptySubtitle,
      );
    }

    return ListView.builder(
      padding: AppSizes.paddingV8,
      itemCount: data.jobRequests.length,
      itemBuilder: (context, index) {
        final item = data.jobRequests[index];
        return JobRequestCard(
          userName: item.userName,
          userAvatar: item.userAvatar,
          title: item.title,
          description: item.description,
          priceRange: item.priceRange,
          timeAgo: item.timeAgo,
          images: item.images,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JobRequestDetailScreen(
                  userName: item.userName,
                  userAvatar: item.userAvatar,
                  title: item.title,
                  description: item.description,
                  priceRange: item.priceRange,
                  images: item.images,
                ),
              ),
            );
          },
          onBidTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JobRequestDetailScreen(
                  userName: item.userName,
                  userAvatar: item.userAvatar,
                  title: item.title,
                  description: item.description,
                  priceRange: item.priceRange,
                  images: item.images,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
