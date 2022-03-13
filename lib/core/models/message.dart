class Message {
  String messageId;
  String content;
  String senderId;
  String recipientId;
  DateTime sentTime;

  Message({
    required this.messageId,
    required this.content,
    required this.senderId,
    required this.recipientId,
    required this.sentTime,
  });
}
