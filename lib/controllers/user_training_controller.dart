import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';

class UserTrainingController extends GetxController {
  var isLoading = false.obs;
  var trainings = [].obs;
  var filtered_list = [].obs;
  var isFetching = false.obs;
  var training_details = {}.obs;
  var isApplying = false.obs;

  @override
  Future onInit() async {
    super.onInit();
    fetchTrainings();
  }

  fetchTrainings() async {
    var token = await StorageService.getToken();
    isLoading(true);

    try {
      http.Response response = await http.get(
          Uri.tryParse(
              '${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.trainings}')!,
          headers: {
            'Authorization': "Bearer $token",
            'X-Requested-With': 'XMLHttpRequest'
          });

      if (response.statusCode == 200) {
        var results = jsonDecode(response.body);
        trainings.value = results;
      }
    } catch (e) {
      Get.snackbar('Error',
          'We could not fetch trainings at this time. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  Future<void> navigateByCategory(String type) async {
    var categoryTrainings = trainings
        .where((item) => item["category"].toLowerCase() == type.toLowerCase())
        .toList();
    filtered_list.value = categoryTrainings;
    if (categoryTrainings.isNotEmpty) {
      Get.toNamed("/training-list-items", arguments: {'category': type});
    } else {
      Get.snackbar('Error', 'There are no trainings for the selected category');
    }
  }

  Future<void> fetchTrainingDetails(trainingId) async {
    var token = await StorageService.getToken();
    isFetching(true);
    try {
      http.Response response = await http.get(
          Uri.tryParse(
              '${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.training_details}/$trainingId')!,
          headers: {
            'Authorization': "Bearer $token",
            'X-Requested-With': 'XMLHttpRequest'
          });

      var details = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // print("success ${details}");
        training_details.value = details;
        Get.toNamed("/basic-training");
      }
      if (response.statusCode == 404) {
        Get.snackbar(
            'Error', 'There are no training details found for the training.');
      }
      isFetching(false);
    } catch (e) {
      Get.snackbar('Error', 'There are no training details found.');
    } finally {
      isFetching(false);
    }
  }

  Future<void> trainingApplication(
      trainingId, trainingDate, trainingParticipants) async {
    var token = await StorageService.getToken();
    isApplying(true);

    final Map<String, dynamic> payload = {
      "training_id": trainingId,
      "start_date": trainingDate,
      "number_of_participants": trainingParticipants
    };

    try {
      final response = await http.post(
        Uri.parse("${ApiEndpoints.baseUrl}/user-trainings"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
          'X-Requested-With': 'XMLHttpRequest'
        },
        body: jsonEncode(payload),
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // print(result);
        Get.snackbar('Success',
            'Your training request application has been submitted successfully.');
        Get.toNamed("/home");
      } else {
        Get.snackbar('Error', 'Could not submit the training request.');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Could not submit the training request.');
      isApplying(false);
    } finally {
      isApplying(false);
    }
  }
}
