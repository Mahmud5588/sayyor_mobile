import 'package:sayyor/core/l10n/app_localizations.dart';

class ChatListMockData {
  final int id;
  final String masterName;
  final String masterImageUrl;
  final bool isOnline;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const ChatListMockData({
    required this.id,
    required this.masterName,
    required this.masterImageUrl,
    required this.isOnline,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });
}

class ChatMockRepository {
  Future<List<ChatListMockData>> loadChats(AppLocalizations l10n) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return <ChatListMockData>[
      ChatListMockData(
        id: 1,
        masterName: 'Alisher Tursunov',
        masterImageUrl: 'https://i.pravatar.cc/150?img=11',
        isOnline: true,
        lastMessage: l10n.chatPreviewOneMessage,
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 2,
      ),
      ChatListMockData(
        id: 2,
        masterName: 'Valiyev Sherzod (Elektrik)',
        masterImageUrl: 'https://i.pravatar.cc/150?img=12',
        isOnline: false,
        lastMessage: l10n.chatPreviewTwoMessage,
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
        unreadCount: 0,
      ),
    ];
  }
}
