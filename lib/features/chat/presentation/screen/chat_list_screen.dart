import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart'; // .tr() uchun
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_colors.dart';

import 'chat_detail_screen.dart';
import 'chat_item_model.dart';
// import 'chat_model.dart'; // Model faylni import qilasiz
// import 'chat_detail_screen.dart'; // Chat Detail imports

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  // Test ma'lumotlari
  final List<ChatListItemModel> _chats = [
    ChatListItemModel(
      id: 1,
      masterName: "Alisher Tursunov",
      masterImageUrl: "https://i.pravatar.cc/150?img=11",
      isOnline: true,
      lastMessage: "Xizmat narxi 150 000 so'm bo'ladi.",
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
    ),
    ChatListItemModel(
      id: 2,
      masterName: "Valiyev Sherzod (Elektrik)",
      masterImageUrl: "https://i.pravatar.cc/150?img=12",
      isOnline: false,
      lastMessage: "Hozir bandman, 2 soatdan keyin boraman.",
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Chatlar", style: theme.textTheme.headlineSmall),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: AppSizes.paddingH16,
        itemCount: _chats.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = _chats[index];

          return ListTile(
            contentPadding: AppSizes.paddingV12,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailScreen(masterName: chat.masterName, imageUrl: chat.masterImageUrl, isNewChat: false,)));
            },

            // 1. Usta Rasmi va Online Status
            leading: Stack(
              children: [
                ClipRRect(
                  borderRadius: AppSizes.borderRadius12,
                  child: Image.network(
                    chat.masterImageUrl,
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                ),
                // Online/Offline Dumaloq Icon
                Positioned(
                  right: -2.w,
                  bottom: -2.h,
                  child: Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: chat.isOnline ? AppColors.kSuccess : AppColors.kGray300,
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.colorScheme.surface, width: 2.w),
                    ),
                  ),
                ),
              ],
            ),

            // 2. Ma'lumotlar
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    chat.masterName,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppSizes.gW8,
                Text(
                  _formatTime(chat.lastMessageTime),
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                ),
              ],
            ),

            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    chat.lastMessage,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Xabarlar soni (agar bo'lsa)
                if (chat.unreadCount > 0) ...[
                  AppSizes.gW8,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      "${chat.unreadCount}",
                      style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    // Oddiy vaqt formati (soat:daqiqa)
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}