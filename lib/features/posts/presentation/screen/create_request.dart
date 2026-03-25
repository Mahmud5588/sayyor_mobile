import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_colors.dart';

class CreateRequestScreen extends StatefulWidget {
  final bool isMasterMode;

  const CreateRequestScreen({super.key, this.isMasterMode = false});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  // Tanlangan rasmlar (Test uchun bo'sh ro'yxat)
  // Haqiqiy loyihada bu yerda File yoki XFile ro'yxati bo'ladi
  final List<String> _selectedImages = [];
  final int _maxImages = 5;
  final List<String> _districts = [
    "Yunusobod",
    "Chilonzor",
    "Mirzo Ulug'bek",
    "Olmazor",
    "Yakkasaroy",
    "Sergeli",
  ];
  String _selectedDistrict = "Yunusobod";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isMasterMode ? "Ish joylash" : "E'lon berish",
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: AppSizes.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. RASMLAR QISMI (4-5 tagacha)
            Text(
              widget.isMasterMode
                  ? "Ish rasmlari (Maksimal $_maxImages ta)"
                  : "Muammo rasmlari (Maksimal $_maxImages ta)",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSizes.gH8,
            Text(
              widget.isMasterMode
                  ? "Bajargan ishingizdan namunalar joylang."
                  : "Holatni yaxshiroq tushuntirish uchun rasm yuklang.",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            AppSizes.gH12,

            // Rasmlar ro'yxati
            Wrap(
              spacing: AppSizes.w12,
              runSpacing: AppSizes.h12,
              children: [
                // Rasm qo'shish tugmasi
                if (_selectedImages.length < _maxImages)
                  InkWell(
                    onTap: () {
                      // TODO: Image Picker mantiqini qo'shish
                      setState(() {
                        _selectedImages.add("Yangi rasm");
                      });
                    },
                    borderRadius: AppSizes.borderRadius12,
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color:
                            theme.colorScheme.surfaceVariant?.withOpacity(
                              0.5,
                            ) ??
                            Colors.grey.shade100,
                        border: AppSizes.borderAll(
                          color: theme.colorScheme.primary.withOpacity(0.5),
                        ),
                        borderRadius: AppSizes.borderRadius12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            color: theme.colorScheme.primary,
                            size: 24.sp,
                          ),
                          AppSizes.gH4,
                          Text(
                            "Qo'shish",
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Tanlangan rasmlar
                ...List.generate(_selectedImages.length, (index) {
                  return Stack(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant,
                          borderRadius: AppSizes.borderRadius12,
                        ),
                        child: Icon(
                          Icons.image,
                          color: theme.colorScheme.outline,
                          size: 32.sp,
                        ), // Test icon
                      ),
                      // O'chirish tugmasi
                      Positioned(
                        top: 4.h,
                        right: 4.w,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedImages.removeAt(index);
                            });
                          },
                          child: Container(
                            padding: AppSizes.padding4,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            AppSizes.gH24,

            if (!widget.isMasterMode) ...[
              Text(
                "Muammo nomi",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizes.gH8,
              TextField(
                decoration: InputDecoration(
                  hintText: "Masalan: Jo'mrakdan suv oqyapti",
                  filled: true,
                  fillColor:
                      theme.colorScheme.surfaceVariant?.withOpacity(0.3) ??
                      Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: AppSizes.borderRadius12,
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppSizes.borderRadius12,
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              AppSizes.gH24,

              Text(
                "Tuman",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizes.gH8,
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined, size: 20.sp),
                  filled: true,
                  fillColor:
                      theme.colorScheme.surfaceVariant?.withOpacity(0.3) ??
                      Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: AppSizes.borderRadius12,
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppSizes.borderRadius12,
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline.withOpacity(0.2),
                    ),
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
                  setState(() {
                    _selectedDistrict = value;
                  });
                },
              ),
              AppSizes.gH24,
            ],

            Text(
              widget.isMasterMode ? "Ish tavsifi" : "Batafsil ma'lumot",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSizes.gH8,
            TextField(
              maxLines: 4, // Kattaroq joy
              decoration: InputDecoration(
                hintText: widget.isMasterMode
                    ? "Bajarilgan ish haqida qisqacha yozing..."
                    : "Usta vaziyatni to'liq tushunishi uchun batafsil yozing...",
                filled: true,
                fillColor:
                    theme.colorScheme.surfaceVariant?.withOpacity(0.3) ??
                    Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: AppSizes.borderRadius12,
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppSizes.borderRadius12,
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            AppSizes.gH24,

            if (!widget.isMasterMode) ...[
              Text(
                "Narx oralig'i (Taxminiy)",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizes.gH8,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Dan (So'm)",
                        prefixIcon: Icon(Icons.payments_outlined, size: 20.sp),
                        filled: true,
                        fillColor:
                            theme.colorScheme.surfaceVariant?.withOpacity(
                              0.3,
                            ) ??
                            Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: AppSizes.borderRadius12,
                          borderSide: BorderSide(
                            color: theme.colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: AppSizes.borderRadius12,
                          borderSide: BorderSide(
                            color: theme.colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppSizes.gW12,
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Gacha (So'm)",
                        filled: true,
                        fillColor:
                            theme.colorScheme.surfaceVariant?.withOpacity(
                              0.3,
                            ) ??
                            Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: AppSizes.borderRadius12,
                          borderSide: BorderSide(
                            color: theme.colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: AppSizes.borderRadius12,
                          borderSide: BorderSide(
                            color: theme.colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppSizes.gH32,
            ] else ...[
              AppSizes.gH32,
            ],

            // 5. JO'NATISH TUGMASI
            SizedBox(
              width: double.infinity, // Butun kenglikni egallashi uchun
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Serverga yuborish
                },
                child: Text(
                  widget.isMasterMode
                      ? "Ishni portfolio ga qo'shish"
                      : "E'lonni joylashtirish",
                ),
              ),
            ),
            AppSizes.gH24,
          ],
        ),
      ),
    );
  }
}
