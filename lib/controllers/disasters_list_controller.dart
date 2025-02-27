import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisastersListController extends GetxController {
  var isLoading = false.obs;
  var disasters = [].obs;
  // OpenseaModel? openseaModel;

  @override
  Future onInit() async {
    super.onInit();
    fetchData();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Returns null if not found
  }

  fetchData() async {
    String? token = await getToken();

    try {
      isLoading(true);
      http.Response response = await http.get(
          Uri.tryParse(
              '${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.disasters}')!,
          headers: {
            'Authorization': "Bearer $token",
            'X-Requested-With': 'XMLHttpRequest'
          });
      if (response.statusCode == 200) {
        //data returned
        var result = jsonDecode(response.body);
        disasters.value = result["data"];
        isLoading(false);
      } else {
        // print('error fetching data');
      }
    } catch (e) {
      // print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
