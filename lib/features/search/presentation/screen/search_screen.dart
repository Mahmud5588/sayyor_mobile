import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/themes/app_sizes.dart';

import '../../../home/presentation/widget/master_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> _quickFilters = [
    "Barchasi",
    "Menga eng yaqin",
    "Eng arzon",
    "Top reyting",
    "Yangi ustalar",
  ];
  int _selectedQuickFilter = 0;

  RangeValues _priceRange = const RangeValues(50000, 1000000);
  String _selectedCategory = "Santexnik";
  String _selectedDistrict = "Yunusobod";
  final List<String> _categories = [
    "Santexnik",
    "Elektrik",
    "Tozalash",
    "Duradgor",
    "Mebel ustasi",
  ];
  final List<String> _districts = [
    "Yunusobod",
    "Chilonzor",
    "Mirzo Ulug'bek",
    "Olmazor",
    "Shayxontohur",
    "Yakkasaroy",
    "Sergeli",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Qidiruv", style: theme.textTheme.headlineSmall),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.w16,
              vertical: AppSizes.h8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Xizmat yoki ismni qidiring...",
                      hintStyle: theme.textTheme.bodyMedium,
                      prefixIcon: Icon(
                        Icons.search,
                        color: theme.colorScheme.outline,
                        size: 24.sp,
                      ),
                      filled: true,
                      fillColor:
                          theme.colorScheme.surfaceVariant?.withOpacity(0.5) ??
                          Colors.grey.shade100,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: AppSizes.borderRadius16,
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                AppSizes.gW12,

                InkWell(
                  onTap: _showAdvancedFilterBottomSheet,
                  borderRadius: AppSizes.borderRadius16,
                  child: Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: AppSizes.borderRadius16,
                    ),
                    child: Icon(
                      Icons.tune,
                      color: theme.colorScheme.onPrimary,
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 50.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: AppSizes.paddingH16,
              itemCount: _quickFilters.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedQuickFilter == index;
                return Padding(
                  padding: EdgeInsets.only(right: AppSizes.w8),
                  child: ChoiceChip(
                    label: Text(_quickFilters[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedQuickFilter = index;
                      });
                    },
                    selectedColor: theme.colorScheme.primaryContainer,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSizes.borderRadius20,
                      side: BorderSide(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outline.withOpacity(0.3),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          AppSizes.gH8,

          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return MasterCardWidget(
                  imageUrl: "https://i.pravatar.cc/150?img=10",
                  name: "Valiyev Sherzod",
                  profession: _selectedCategory,
                  priceRange: "150,000 - 300,000 UZS",
                  location:
                      "Chilonzor tumani, 9-kvartal (${(index + 1) * 1.5} km)",
                  rating: 4.9,
                  reviewsCount: 85 + index,
                  isBusy: index.isOdd,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAdvancedFilterBottomSheet() {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: AppSizes.padding24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Filtrlar", style: theme.textTheme.headlineSmall),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, size: 24.sp),
                      ),
                    ],
                  ),
                  const Divider(),
                  AppSizes.gH16,

                  Text("Lokatsiya", style: theme.textTheme.titleMedium),
                  AppSizes.gH8,
                  DropdownButtonFormField<String>(
                    value: _selectedDistrict,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on_outlined, size: 24.sp),
                      border: OutlineInputBorder(
                        borderRadius: AppSizes.borderRadius12,
                      ),
                    ),
                    items: _districts
                        .map(
                          (district) => DropdownMenuItem<String>(
                            value: district,
                            child: Text(district),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setModalState(() => _selectedDistrict = value);
                      setState(() => _selectedDistrict = value);
                    },
                  ),
                  AppSizes.gH24,

                  Text("Xizmat turi", style: theme.textTheme.titleMedium),
                  AppSizes.gH8,
                  Wrap(
                    spacing: AppSizes.w8,
                    runSpacing: AppSizes.h8,
                    children: _categories.map((cat) {
                      final isSel = _selectedCategory == cat;
                      return ChoiceChip(
                        label: Text(cat),
                        selected: isSel,
                        onSelected: (val) {
                          setModalState(() => _selectedCategory = cat);
                          setState(() => _selectedCategory = cat);
                        },
                        selectedColor: theme.colorScheme.primaryContainer,
                      );
                    }).toList(),
                  ),
                  AppSizes.gH24,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Xizmat narxi (UZS)",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        "${(_priceRange.start / 1000).toStringAsFixed(0)}k - ${(_priceRange.end / 1000).toStringAsFixed(0)}k",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 2000000,
                    divisions: 20,
                    activeColor: theme.colorScheme.primary,
                    labels: RangeLabels(
                      "${_priceRange.start.round()}",
                      "${_priceRange.end.round()}",
                    ),
                    onChanged: (RangeValues values) {
                      setModalState(() {
                        _priceRange = values;
                      });
                    },
                  ),
                  AppSizes.gH24,

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Natijalarni ko'rsatish"),
                    ),
                  ),
                  AppSizes.gH16,
                ],
              ),
            );
          },
        );
      },
    );
  }
}
