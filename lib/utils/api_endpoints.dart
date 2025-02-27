class ApiEndpoints {
  static const String baseUrl = 'https://urcs-api.taufeeq.dev/api';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = '/auth/register';
  final String login = 'auth/login';
  final String disasters = 'disasters';
  final String ambulances = '/auth/ambulances';
  final String ambulance_requests = 'ambulance-requests';
  final String trainings = 'trainings';
  final String training_details = 'user-trainings';
  final String training_application = 'user-trainings';
}
