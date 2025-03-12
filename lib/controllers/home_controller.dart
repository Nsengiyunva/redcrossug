import 'package:get/get.dart';
import 'package:redcross/utils/storage_service.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var fullName = ''.obs;
  var phoneNumber = ''.obs;

  @override
  Future onInit() async {
    super.onInit();
    fetchFullName();
  }

  fetchFullName() async {
    isLoading(true);
    try {
      var retrievedUser = await StorageService.getUser();
      fullName.value = retrievedUser!.name;
      phoneNumber.value = retrievedUser.phone_no;
      isLoading(false);
    } catch (e) {
      print("e $e");
    } finally {
      isLoading(false);
    }
  }
}
