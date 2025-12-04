// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/models/blood_donation_faq.dart';
import 'package:redcross/utils/api_endpoints.dart';

class BloodDonationFaqController extends GetxController {
  var isLoading = false.obs;
  var faqs = <BloodDonationFaq>[].obs;
  var categories = <FaqCategory>[].obs;
  var selectedCategory = Rxn<String>();
  var searchQuery = ''.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchFaqs();
  }

  /// Fetch available FAQ categories
  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}/blood-donation/faqs/categories'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final Map<String, dynamic> categoriesData = data['data'];
          categories.value = categoriesData.entries
              .map((entry) => FaqCategory.fromJson(entry.key, entry.value))
              .toList();
        }
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  /// Fetch FAQs with optional category filter
  Future<void> fetchFaqs({String? category}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String url = '${ApiEndpoints.baseUrl}/blood-donation/faqs';
      if (category != null && category.isNotEmpty) {
        url += '?category=$category';
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final List<dynamic> faqsData = data['data'];
          faqs.value = faqsData
              .map((faqJson) => BloodDonationFaq.fromJson(faqJson))
              .toList();
        } else {
          errorMessage.value = 'Failed to load FAQs';
        }
      } else {
        errorMessage.value = 'Server error. Please try again later.';
      }
    } catch (e) {
      errorMessage.value = 'Network error. Please check your connection.';
      print('Error fetching FAQs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Search FAQs using full-text search
  Future<void> searchFaqs(String query) async {
    if (query.isEmpty) {
      fetchFaqs(category: selectedCategory.value);
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';
      searchQuery.value = query;

      final response = await http.get(
        Uri.parse(
            '${ApiEndpoints.baseUrl}/blood-donation/faqs/search?q=${Uri.encodeComponent(query)}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final List<dynamic> faqsData = data['data'];
          faqs.value = faqsData
              .map((faqJson) => BloodDonationFaq.fromJson(faqJson))
              .toList();
        } else {
          errorMessage.value = data['message'] ?? 'Search failed';
        }
      } else {
        errorMessage.value = 'Search failed. Please try again.';
      }
    } catch (e) {
      errorMessage.value = 'Network error. Please check your connection.';
      print('Error searching FAQs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Filter by category
  void filterByCategory(String? category) {
    selectedCategory.value = category;
    searchQuery.value = ''; // Clear search when filtering by category
    fetchFaqs(category: category);
  }

  /// Clear filters and search
  void clearFilters() {
    selectedCategory.value = null;
    searchQuery.value = '';
    fetchFaqs();
  }

  /// Refresh FAQs
  Future<void> refreshFaqs() async {
    await fetchFaqs(category: selectedCategory.value);
  }
}
