class ApiConstants {
  static const String baseUrl = 'http://161.35.53.140:3200/api';
  static const String registerEndpoint = '/register';
  static const String loginEndpoint = '/login';
  static const String experienceEndpoint = '/experience';
  static const String pinEndpoint = '/securityParent';
  static const String createActivityEndpoint = '/createActivity';
  static const String getActivityEndpoint = '/getAllActivity';
  static const String getActivityKidEndpoint = '/getActivityByKid';
  static const String updateActivity = '/updateActivityStatus';
  static const String getProfileDetails = '/getProfileDetails';
  static const String updateProfileDetails = '/updateProfile';
  static const String updatePinToken = '/updatePin';
  static const String stripePaymentIntent = '/donation';
  static const String createTasksEndpoint = '/createTask';
  static const String getTaskByKid = '/getTaskByKid';
  static const String updateTaskStatus = '/updateStatusTask';
  static const String createMapsDetails = '/createMaps';
  static const String getMapsDetails = '/getMapByParent';
  static const String updateMapsDetails = '/updateMaps';
  static const String recoverAccountEndpoint = '/recoverAccount';
  static const String sendPinByEmailEndpoint = '/senderPin';
}
