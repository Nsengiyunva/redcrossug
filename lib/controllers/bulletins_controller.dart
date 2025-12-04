import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/models/bulletin.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';

class BulletinsController extends GetxController {
  var isLoading = false.obs;
  var bulletins = <Bulletin>[].obs;
  var selectedCategory = Rxn<BulletinCategory>();
  var errorMessage = ''.obs;
  var currentPage = 1.obs;
  var hasMorePages = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBulletins();
  }

  /// Fetch bulletins with optional category filter
  Future<void> fetchBulletins({BulletinCategory? category, bool loadMore = false}) async {
    try {
      if (loadMore) {
        if (!hasMorePages.value) return;
        currentPage.value++;
      } else {
        isLoading.value = true;
        currentPage.value = 1;
        hasMorePages.value = true;
      }
      
      errorMessage.value = '';

      String url = '${ApiEndpoints.baseUrl}/bulletins?page=${currentPage.value}';
      if (category != null) {
        url += '&category=${category.value}';
      }

      final token = await StorageService.getToken();
      if (token == null) {
        errorMessage.value = 'Authentication required';
        isLoading.value = false;
        return;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Handle Laravel pagination structure
        final List<dynamic> bulletinsData = data['data'] as List<dynamic>;
        final newBulletins = bulletinsData
            .map((bulletinJson) => Bulletin.fromJson(bulletinJson))
            .toList();

        if (loadMore) {
          bulletins.addAll(newBulletins);
        } else {
          bulletins.value = newBulletins;
        }

        // Check if there are more pages
        if (data['next_page_url'] == null) {
          hasMorePages.value = false;
        }
      } else if (response.statusCode == 401) {
        errorMessage.value = 'Session expired. Please login again.';
      } else {
        errorMessage.value = 'Failed to load bulletins';
      }
    } catch (e) {
      errorMessage.value = 'Network error. Please check your connection.';
      print('Error fetching bulletins: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Filter by category
  void filterByCategory(BulletinCategory? category) {
    selectedCategory.value = category;
    fetchBulletins(category: category);
  }

  /// Clear filters
  void clearFilters() {
    selectedCategory.value = null;
    fetchBulletins();
  }

  /// Refresh bulletins
  Future<void> refreshBulletins() async {
    await fetchBulletins(category: selectedCategory.value);
  }

  /// Load more bulletins (pagination)
  Future<void> loadMoreBulletins() async {
    await fetchBulletins(category: selectedCategory.value, loadMore: true);
  }

  /// Get bulletin by ID
  Future<Bulletin?> getBulletinById(int id) async {
    try {
      final token = await StorageService.getToken();
      if (token == null) return null;

      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}/bulletins/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Bulletin.fromJson(data);
      }
    } catch (e) {
      print('Error fetching bulletin details: $e');
    }
    return null;
  }

  /// Get bulletins by subtype (helper method)
  List<Bulletin> getBulletinsBySubtype(BulletinSubtype subtype) {
    return bulletins.where((b) => b.subtype == subtype).toList();
  }

  /// Get urgent bulletins (critical priority)
  List<Bulletin> getUrgentBulletins() {
    return bulletins.where((b) => b.priority == 'critical').toList();
  }

  /// Get upcoming events
  List<Bulletin> getUpcomingEvents() {
    final now = DateTime.now();
    return bulletins.where((b) {
      if (b.subtype == null) return false;
      if (![BulletinSubtype.event, BulletinSubtype.campaign, BulletinSubtype.training]
          .contains(b.subtype)) return false;
      if (b.eventStartDate == null) return false;
      return b.eventStartDate!.isAfter(now);
    }).toList();
  }
}
