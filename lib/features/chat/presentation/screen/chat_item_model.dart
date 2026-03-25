enum ChatStatus { pending, accepted, rejected }

class ChatListItemModel {
  final int id;
  final String masterName;
  final String masterImageUrl;
  final bool isOnline;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  ChatListItemModel({
    required this.id,
    required this.masterName,
    required this.masterImageUrl,
    required this.isOnline,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });
}

class MessageModel {
  final String text;
  final bool isMe;
  final DateTime time;
  final bool isLocation;
  final bool isImage;

  MessageModel({
    required this.text,
    required this.isMe,
    required this.time,
    this.isLocation = false,
    this.isImage = false,
  });
}