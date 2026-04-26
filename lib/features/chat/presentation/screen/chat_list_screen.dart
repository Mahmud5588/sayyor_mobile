import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/di/service_locator.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_colors.dart';
import 'package:sayyor/core/widgets/app_async_state_view.dart';
import 'package:sayyor/features/chat/data/chat_mock_repository.dart';

import 'chat_detail_screen.dart';
// import 'chat_model.dart'; // Model faylni import qilasiz
// import 'chat_detail_screen.dart'; // Chat Detail imports

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late Future<List<ChatListMockData>> _chatFuture;
  String? _loadedLocaleKey;

  final ChatMockRepository _repository = sl<ChatMockRepository>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localeKey = Localizations.localeOf(context).toLanguageTag();
    if (_loadedLocaleKey != localeKey) {
      _loadedLocaleKey = localeKey;
      _chatFuture = _repository.loadChats(AppLocalizations.of(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chatListTitle, style: theme.textTheme.headlineSmall),
        centerTitle: false,
      ),
      body: FutureBuilder<List<ChatListMockData>>(
        future: _chatFuture,
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

          final chats = snapshot.data ?? const <ChatListMockData>[];
          if (chats.isEmpty) {
            return AppAsyncStateView.empty(
              l10n: l10n,
              subtitle: l10n.chatListEmptySubtitle,
            );
          }

          return ListView.separated(
            padding: AppSizes.paddingH16,
            itemCount: chats.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final chat = chats[index];

              return ListTile(
                contentPadding: AppSizes.paddingV12,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailScreen(
                        masterName: chat.masterName,
                        imageUrl: chat.masterImageUrl,
                        isNewChat: false,
                      ),
                    ),
                  );
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
                    Positioned(
                      right: -2.w,
                      bottom: -2.h,
                      child: Container(
                        width: 14.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: chat.isOnline
                              ? AppColors.kSuccess
                              : AppColors.kGray300,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.surface,
                            width: 2.w,
                          ),
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
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AppSizes.gW8,
                    Text(
                      _formatTime(chat.lastMessageTime),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),

                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text(
                        chat.lastMessage,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (chat.unreadCount > 0) ...[
                      AppSizes.gW8,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          "${chat.unreadCount}",
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
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
