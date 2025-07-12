enum NotificationWay { sms, email }

extension NotificationWayLabel on NotificationWay {
  String get label {
    switch (this) {
      case NotificationWay.sms:
        return "SMS";
      case NotificationWay.email:
        return "Email";
    }
  }
}
