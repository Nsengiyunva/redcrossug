import 'dart:convert';
import 'package:get/get.dart';
// import 'package:getx_tutorials/models/opensea_model.dart';
import 'package:http/http.dart' as http;
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
      http.Response response = await http.get(Uri.tryParse(
          'https://urcs-api.taufeeq.dev/api/disasters')!, headers: {
          'Authorization': "Bearer ${token}",
          'X-Requested-With': 'XMLHttpRequest'
          } );
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print( result );
        disasters.value = result["data"];
        // openseaModel = OpenseaModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}