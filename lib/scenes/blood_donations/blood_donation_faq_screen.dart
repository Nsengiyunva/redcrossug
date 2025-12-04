// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/blood_donation_faq_controller.dart';
import 'package:redcross/models/blood_donation_faq.dart';
import 'package:redcross/utils/colors.dart';

class BloodDonationFaqScreen extends StatefulWidget {
  const BloodDonationFaqScreen({super.key});

  @override
  State<BloodDonationFaqScreen> createState() => _BloodDonationFaqScreenState();
}

class _BloodDonationFaqScreenState extends State<BloodDonationFaqScreen> {
  final BloodDonationFaqController controller =
      Get.put(BloodDonationFaqController());
  final TextEditingController searchController = TextEditingController();
  final Set<int> expandedItems = {};

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text(
          'Blood Donation FAQs',
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.whiteColor,
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search FAQs...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              controller.clearFilters();
                            },
                          )
                        : const SizedBox.shrink()),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primaryRedColor,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      controller.searchFaqs(value);
                    }
                  },
                ),
                const SizedBox(height: 12),
                // Category Filter Chips
                Obx(() => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // All Categories Chip
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: const Text('All'),
                              selected: controller.selectedCategory.value == null,
                              onSelected: (selected) {
                                if (selected) {
                                  controller.filterByCategory(null);
                                }
                              },
                              selectedColor: AppColors.primaryRedColor,
                              labelStyle: TextStyle(
                                color: controller.selectedCategory.value == null
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight:
                                    controller.selectedCategory.value == null
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                          ),
                          // Category Chips
                          ...controller.categories.map((category) {
                            final isSelected =
                                controller.selectedCategory.value == category.key;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(category.label),
                                selected: isSelected,
                                onSelected: (selected) {
                                  controller.filterByCategory(
                                      selected ? category.key : null);
                                },
                                selectedColor: AppColors.primaryRedColor,
                                labelStyle: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight:
                                      isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          // FAQ List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryRedColor,
                  ),
                );
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          controller.errorMessage.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => controller.refreshFaqs(),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryRedColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (controller.faqs.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help_outline,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          controller.searchQuery.value.isNotEmpty
                              ? 'No FAQs found for "${controller.searchQuery.value}"'
                              : 'No FAQs available',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        if (controller.searchQuery.value.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              searchController.clear();
                              controller.clearFilters();
                            },
                            child: const Text('Clear Search'),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.refreshFaqs(),
                color: AppColors.primaryRedColor,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.faqs.length,
                  itemBuilder: (context, index) {
                    final faq = controller.faqs[index];
                    return FaqAccordionItem(
                      faq: faq,
                      isExpanded: expandedItems.contains(faq.id),
                      onToggle: () {
                        setState(() {
                          if (expandedItems.contains(faq.id)) {
                            expandedItems.remove(faq.id);
                          } else {
                            expandedItems.add(faq.id);
                          }
                        });
                      },
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class FaqAccordionItem extends StatelessWidget {
  final BloodDonationFaq faq;
  final bool isExpanded;
  final VoidCallback onToggle;

  const FaqAccordionItem({
    super.key,
    required this.faq,
    required this.isExpanded,
    required this.onToggle,
  });

  String _getCategoryIcon(String category) {
    switch (category) {
      case 'general':
        return '📋';
      case 'eligibility':
        return '✅';
      case 'process':
        return '🔄';
      case 'health':
        return '💚';
      case 'benefits':
        return '🎁';
      default:
        return '❓';
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'general':
        return Colors.blue.shade50;
      case 'eligibility':
        return Colors.green.shade50;
      case 'process':
        return Colors.orange.shade50;
      case 'health':
        return Colors.purple.shade50;
      case 'benefits':
        return Colors.pink.shade50;
      default:
        return Colors.grey.shade50;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isExpanded
              ? AppColors.primaryRedColor
              : Colors.grey.shade200,
          width: isExpanded ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(faq.category),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getCategoryIcon(faq.category),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Question
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          faq.question,
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        if (faq.relevanceScore != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.amber.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Relevance: ${(faq.relevanceScore! * 100).toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Expand/Collapse Icon
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: isExpanded
                        ? AppColors.primaryRedColor
                        : Colors.grey.shade600,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
          // Answer (Expandable)
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    faq.answer,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
