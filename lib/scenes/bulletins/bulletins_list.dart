// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/bulletins_controller.dart';
import 'package:redcross/models/bulletin.dart';
import 'package:redcross/scenes/bulletins/bulletin_detail.dart';
import 'package:redcross/utils/colors.dart';
import 'package:intl/intl.dart';

class BulletinsList extends StatefulWidget {
  const BulletinsList({super.key});

  @override
  State<BulletinsList> createState() => _BulletinsListState();
}

class _BulletinsListState extends State<BulletinsList> {
  final BulletinsController controller = Get.put(BulletinsController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      controller.loadMoreBulletins();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bulletins & Updates',
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryRedColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.bulletins.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.errorMessage.value.isNotEmpty &&
                  controller.bulletins.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.errorMessage.value,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Inter",
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => controller.refreshBulletins(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryRedColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.bulletins.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.campaign_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No bulletins available',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Check back later for updates',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Inter",
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.refreshBulletins(),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.bulletins.length +
                      (controller.hasMorePages.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.bulletins.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final bulletin = controller.bulletins[index];
                    return _buildBulletinCard(bulletin);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() => ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildCategoryChip('All', null),
              const SizedBox(width: 8),
              _buildCategoryChip(
                'Blood Donation',
                BulletinCategory.bloodDonation,
              ),
              const SizedBox(width: 8),
              _buildCategoryChip(
                'Disasters',
                BulletinCategory.disasterManagement,
              ),
              const SizedBox(width: 8),
              _buildCategoryChip(
                'First Aid',
                BulletinCategory.firstAid,
              ),
            ],
          )),
    );
  }

  Widget _buildCategoryChip(String label, BulletinCategory? category) {
    final isSelected = controller.selectedCategory.value == category;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        controller.filterByCategory(category);
      },
      labelStyle: TextStyle(
        fontFamily: "Inter",
        fontWeight: FontWeight.w600,
        color: isSelected ? Colors.white : AppColors.primaryRedColor,
      ),
      backgroundColor: Colors.white,
      selectedColor: AppColors.primaryRedColor,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? AppColors.primaryRedColor : Colors.grey[300]!,
      ),
    );
  }

  Widget _buildBulletinCard(Bulletin bulletin) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BulletinDetail(bulletin: bulletin),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bulletin.featuredImage != null) _buildImage(bulletin),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildCategoryBadge(bulletin.category),
                      if (bulletin.subtype != null) ...[
                        const SizedBox(width: 8),
                        _buildSubtypeBadge(bulletin.subtype!),
                      ],
                      if (bulletin.priority == 'critical') ...[
                        const SizedBox(width: 8),
                        _buildPriorityBadge(),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    bulletin.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  if (bulletin.excerpt != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      bulletin.excerpt!,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Inter",
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 12),
                  _buildMetadata(bulletin),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(Bulletin bulletin) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Image.network(
        bulletin.featuredImage!,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 180,
            color: Colors.grey[200],
            child: Icon(
              Icons.image_not_supported,
              size: 48,
              color: Colors.grey[400],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryBadge(BulletinCategory category) {
    Color color;
    IconData icon;

    switch (category) {
      case BulletinCategory.bloodDonation:
        color = const Color(0xFFE31E24);
        icon = Icons.water_drop;
        break;
      case BulletinCategory.disasterManagement:
        color = const Color(0xFFFF6F00);
        icon = Icons.warning_amber;
        break;
      case BulletinCategory.firstAid:
        color = const Color(0xFF2E7D32);
        icon = Icons.medical_services;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            category.label,
            style: TextStyle(
              fontSize: 11,
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtypeBadge(BulletinSubtype subtype) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        subtype.label,
        style: TextStyle(
          fontSize: 11,
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.priority_high, size: 14, color: Colors.red[700]),
          const SizedBox(width: 2),
          Text(
            'URGENT',
            style: TextStyle(
              fontSize: 11,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
              color: Colors.red[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadata(Bulletin bulletin) {
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    final List<Widget> metadata = [];

    // Published date
    if (bulletin.publishedAt != null) {
      metadata.add(
        Row(
          children: [
            Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              dateFormat.format(bulletin.publishedAt!),
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Inter",
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    // Event date
    if (bulletin.eventStartDate != null) {
      if (metadata.isNotEmpty) metadata.add(const SizedBox(width: 16));
      metadata.add(
        Row(
          children: [
            Icon(Icons.event, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              dateFormat.format(bulletin.eventStartDate!),
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Inter",
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    // Location
    if (bulletin.eventLocation != null) {
      if (metadata.isNotEmpty) metadata.add(const SizedBox(width: 16));
      metadata.add(
        Row(
          children: [
            Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                bulletin.eventLocation!,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Inter",
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: metadata,
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Filter Bulletins',
          style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All Categories'),
              leading: Radio<BulletinCategory?>(
                value: null,
                groupValue: controller.selectedCategory.value,
                onChanged: (value) {
                  controller.filterByCategory(value);
                  Navigator.pop(context);
                },
              ),
            ),
            ...BulletinCategory.values.map(
              (category) => ListTile(
                title: Text(category.label),
                leading: Radio<BulletinCategory?>(
                  value: category,
                  groupValue: controller.selectedCategory.value,
                  onChanged: (value) {
                    controller.filterByCategory(value);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
