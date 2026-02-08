sealed class AppUrls {
  static const String baseURL = "http://10.0.2.2:8000/api/";

  /// Authentification
  static const String sendOTP = "auth/send-otp";
  static const String verifyOTP = "auth/verify-otp";
  static const String refresh = "auth/refresh";

  ///Services
  static const String services = "services";
  static const String categories = "search/categories";
  static const String serviceTypes = "search/services";
  static const String searchMasters = "search/masters";

  ///Orders
  static const String orders = "orders";
  static const String myOrders = "orders/my-orders";
  static const String ordersStatus = "orders/{order_id}/status";

  ///Chat
  static const String chatSend = "chat/send";
  static const String chatUnread = "chat/unread/count";
  static const String chatMessages = "chat/{order_id}";

  ///Master
  static const String masterDashboard = "master/dashboard";
  static const String masterEarnings = "master/earnings";
  static const String masterAvailability = "master/availability";
  static const String masterIncomingOrders = "master/incoming-orders";
  static const String masterProfile = "master/profile";
  static const String masterCategories = "master/categories";
  static const String masterServices = "master/services";
  static const String masterServiceRequest = "master/services/request";
  static const String masterServiceRequests = "master/service-requests";

  ///User
  static const String user = "user/profile";
  static const String userRate = "user/rate";
  static const String userCities = "user/cities";
  static const String userById = "user/{user_id}";

  ///Notifications
  static const String notifications = "notifications";
  static const String notificationRead = "notifications/{notification_id}/read";
}
