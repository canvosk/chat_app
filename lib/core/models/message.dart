class Message {
  int messageId;
  String content;
  int senderId;
  int recipientId;
  DateTime sentTime;

  Message({
    required this.messageId,
    required this.content,
    required this.senderId,
    required this.recipientId,
    required this.sentTime,
  });
}
