import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_colors.dart';

import '../../../../core/widgets/error_dialog.dart';
import 'chat_item_model.dart';
class ChatDetailScreen extends StatefulWidget {
  final String masterName;
  final String imageUrl;
  final bool isNewChat; // Yangi yoki eski chatligini aniqlash

  const ChatDetailScreen({
    super.key,
    required this.masterName,
    required this.imageUrl,
    this.isNewChat = false,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Chat holati (Test uchun)
  // Yangi chat bo'lsa 'pending', eski bo'lsa 'accepted' deb tasavvur qilamiz
  ChatStatus _chatStatus = ChatStatus.pending;
  int _sentMessagesCount = 0; // Jo'natilgan xabarlar soni
  final int _maxInitialMessages = 2; // Maksimal 2 xabar

  final List<MessageModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _chatStatus = widget.isNewChat ? ChatStatus.pending : ChatStatus.accepted;
    if (!widget.isNewChat) {
      // Test xabarlarini qo'shish
      _messages.add(MessageModel(text: "Salom, nima xizmat?", isMe: false, time: DateTime.now().subtract(const Duration(minutes: 10))));
    }
  }

  // --- MATNNI TEKSHIRISH MANTIQLARI ---
  bool _containsContactInfo(String text) {
    // 1. Telefon raqami tekshiruvi (Oddiy regex)
    final phoneRegex = RegExp(r'(\+?998\d{9})|(\d{9})|(\d{2}[-.\s]?\d{3}[-.\s]?\d{2}[-.\s]?\d{2})');

    // 2. Link tekshiruvi (Oddiy regex)
    final urlRegex = RegExp(r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?');

    return phoneRegex.hasMatch(text) || urlRegex.hasMatch(text);
  }

  // Xabar jo'natish
  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // A. Bosqichli mantiqni tekshirish
    if (_chatStatus == ChatStatus.pending) {
      if (_sentMessagesCount >= _maxInitialMessages) {
        AppSnackBar.showError(context, "Maksimal xabarlar soniga etdingiz. Usta qabul qilishini kuting.");
        return;
      }
    }

    // B. Telefon/Link tekshiruvi
    if (_containsContactInfo(text)) {
      AppSnackBar.showError(context, "Telefon raqami yoki link jo'natish mumkin emas.");
      return;
    }

    // C. Xabarni qo'shish
    setState(() {
      _messages.insert(0, MessageModel(text: text, isMe: true, time: DateTime.now()));
      _messageController.clear();
      if (_chatStatus == ChatStatus.pending) {
        _sentMessagesCount++;
      }
    });
    _scrollToBottom();
  }

  // Test uchun: Usta rozi bo'ldi
  void _acceptChat() {
    setState(() {
      _chatStatus = ChatStatus.accepted;
      _sentMessagesCount = 0; // Sanagichni nolga tushirish
      // Ustaning rozilik xabarini qo'shish (test)
      _messages.insert(0, MessageModel(text: "So'rovingiz qabul qilindi! Muloqotni davom ettirishingiz mumkin.", isMe: false, time: DateTime.now()));
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Kirishdagi ogohlantirish blokini ko'rsatish sharti
    final showInitialWarning = widget.isNewChat && _chatStatus == ChatStatus.pending && _sentMessagesCount == 0;

    // Xabar yozishni cheklash sharti
    final isInputBlocked = _chatStatus == ChatStatus.pending && _sentMessagesCount >= _maxInitialMessages;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(widget.imageUrl, width: 36.w, height: 36.h, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.person)),
            ),
            AppSizes.gW12,
            Expanded(
              child: Text(widget.masterName, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. OGOHLANTIRISH BLOKI (KIRISHDA)
          if (showInitialWarning) _buildInitialWarningBlock(theme),

          // 2. XABARLAR RO'YXATI
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              padding: AppSizes.padding16,
              reverse: true, // Yangi xabar pastda chiqishi uchun
              itemCount: _messages.length,
              separatorBuilder: (c, i) => AppSizes.gH8,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(theme, message);
              },
            ),
          ),

          // 3. BLOKLANGAN HOLATDA OGOHLANTIRISH (Pastda)
          if (isInputBlocked) _buildBlockedWarningBlock(theme),

          // 4. XABAR KIRITISH PANELI
          _buildInputPanel(theme, isInputBlocked),

          // Test Tugmasi: Usta rozi bo'ldi
          if (_chatStatus == ChatStatus.pending && _sentMessagesCount > 0)
            ElevatedButton(onPressed: _acceptChat, child: const Text("Usta: Qabul qilish (TEST TUGMASI)"))
        ],
      ),
    );
  }

  // --- WIDGET QURUVCHILAR ---

  // Kirishdagi Ogohlantirish bloki
  Widget _buildInitialWarningBlock(ThemeData theme) {
    return Container(
      width: double.infinity,
      margin: AppSizes.padding16,
      padding: AppSizes.padding16,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryContainer,
        borderRadius: AppSizes.borderRadius16,
        border: Border.all(color: theme.colorScheme.primary, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: theme.colorScheme.primary, size: 24.sp),
              AppSizes.gW12,
              Text("Ogohlantirish", style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
            ],
          ),
          AppSizes.gH12,
          Text(
            "Iltimos, ish mazmunini birinchi xabarda to'liq yozing.\nSizga jami $_maxInitialMessages ta xabar yozish imkoni beriladi.\nUsta so'rovni qabul qilmaguncha, kontakt ma'lumotlarini (telefon, link) yozish taqiqlanadi.",
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer),
          ),
        ],
      ),
    );
  }

  // Bloklangan holatda pastki ogohlantirish bloki
  Widget _buildBlockedWarningBlock(ThemeData theme) {
    return Container(
      width: double.infinity,
      color: AppColors.kError,
      padding: AppSizes.padding12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, color: theme.colorScheme.error, size: 20.sp),
          AppSizes.gW12,
          Text(
            "Xabar yozish bloklandi. Usta javobini kuting.",
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Xabar pufakchasi (Message Bubble)
  Widget _buildMessageBubble(ThemeData theme, MessageModel message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: AppSizes.padding12,
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: message.isMe ? theme.colorScheme.primary : theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(message.isMe ? 16.r : 4.r),
            bottomRight: Radius.circular(message.isMe ? 4.r : 16.r),
          ),
        ),
        child: Text(
          message.text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: message.isMe ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  // Xabar kiritish paneli
  Widget _buildInputPanel(ThemeData theme, bool isBlocked) {
    // Qabul qilingan bo'lsa qo'shimcha ikonalar chiqadi
    final isAccepted = _chatStatus == ChatStatus.accepted;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w12, vertical: AppSizes.h8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(top: BorderSide(color: theme.colorScheme.outline.withOpacity(0.3))),
      ),
      child: Row(
        children: [
          // Qo'shimcha ikonalar (Qabul qilingan bo'lsa)
          if (isAccepted) ...[
            IconButton(
              onPressed: isBlocked ? null : () {}, // Rasm jo'natish
              icon: Icon(Icons.image_outlined, color: isBlocked ? theme.colorScheme.outline : theme.colorScheme.primary, size: 24.sp),
            ),
            IconButton(
              onPressed: isBlocked ? null : () {}, // Lokatsiya jo'natish
              icon: Icon(Icons.location_on_outlined, color: isBlocked ? theme.colorScheme.outline : theme.colorScheme.primary, size: 24.sp),
            ),
          ],

          // Kiritish maydoni
          Expanded(
            child: TextField(
              controller: _messageController,
              enabled: !isBlocked, // Bloklangan bo'lsa o'chirish
              decoration: InputDecoration(
                hintText: isBlocked ? "Bloklangan..." : "Xabar yozing...",
                contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.w16, vertical: AppSizes.h12),
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant?.withOpacity(0.5) ?? Colors.grey.shade100,
                border: OutlineInputBorder(borderRadius: AppSizes.borderRadius16, borderSide: BorderSide.none),
              ),
              maxLines: null, // Dinamik balandlik
            ),
          ),
          AppSizes.gW8,

          // Jo'natish tugmasi
          IconButton(
            onPressed: isBlocked ? null : _sendMessage,
            icon: Icon(Icons.send_rounded, color: isBlocked ? theme.colorScheme.outline : theme.colorScheme.primary, size: 28.sp),
          ),
        ],
      ),
    );
  }
}