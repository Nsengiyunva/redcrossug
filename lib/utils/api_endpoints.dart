// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

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
  final String donate_payment = 'donate';
  final String donations = 'campaigns';
  final String causes = 'causes';
  final String config_chatwoot = 'config/chatwoot';
  // final String blood_donations = 'campaigns';
}
