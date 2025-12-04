// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:redcross/models/bulletin.dart';
import 'package:redcross/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BulletinDetail extends StatefulWidget {
  final Bulletin bulletin;

  const BulletinDetail({super.key, required this.bulletin});

  @override
  State<BulletinDetail> createState() => _BulletinDetailState();
}

class _BulletinDetailState extends State<BulletinDetail> {
  late final WebViewController _webViewController;
  final DateFormat dateFormat = DateFormat('EEEE, MMMM dd, yyyy');
  final DateFormat timeFormat = DateFormat('h:mm a');

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadHtmlString(_buildHtmlContent());
  }

  String _buildHtmlContent() {
    return '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <style>
        body {
          font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
          padding: 16px;
          margin: 0;
          line-height: 1.6;
          color: #333;
        }
        h1, h2, h3, h4, h5, h6 {
          color: #2C2C2C;
          margin-top: 24px;
          margin-bottom: 12px;
        }
        p {
          margin-bottom: 16px;
        }
        img {
          max-width: 100%;
          height: auto;
          border-radius: 8px;
        }
        a {
          color: #E31E24;
          text-decoration: none;
        }
        a:hover {
          text-decoration: underline;
        }
        ul, ol {
          padding-left: 24px;
          margin-bottom: 16px;
        }
        li {
          margin-bottom: 8px;
        }
        blockquote {
          border-left: 4px solid #E31E24;
          padding-left: 16px;
          margin-left: 0;
          font-style: italic;
          color: #666;
        }
        .content {
          font-size: 16px;
        }
      </style>
    </head>
    <body>
      <div class="content">
        ${widget.bulletin.body}
      </div>
    </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bulletin Details',
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryRedColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.bulletin.featuredImage != null) _buildFeaturedImage(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBadges(),
                  const SizedBox(height: 16),
                  Text(
                    widget.bulletin.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAuthorInfo(),
                  const SizedBox(height: 20),
                  if (widget.bulletin.excerpt != null) ...[
                    Text(
                      widget.bulletin.excerpt!,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  _buildConditionalFields(),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 600,
                    child: WebViewWidget(controller: _webViewController),
                  ),
                  if (widget.bulletin.tags != null &&
                      widget.bulletin.tags!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    _buildTags(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedImage() {
    return Image.network(
      widget.bulletin.featuredImage!,
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 250,
          color: Colors.grey[200],
          child: Icon(
            Icons.image_not_supported,
            size: 64,
            color: Colors.grey[400],
          ),
        );
      },
    );
  }

  Widget _buildBadges() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildCategoryBadge(),
        if (widget.bulletin.subtype != null) _buildSubtypeBadge(),
        if (widget.bulletin.priority == 'critical') _buildPriorityBadge(),
      ],
    );
  }

  Widget _buildCategoryBadge() {
    Color color;
    IconData icon;

    switch (widget.bulletin.category) {
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            widget.bulletin.category.label,
            style: TextStyle(
              fontSize: 13,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtypeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        widget.bulletin.subtype!.label,
        style: TextStyle(
          fontSize: 13,
          fontFamily: "Inter",
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.priority_high, size: 16, color: Colors.red[700]),
          const SizedBox(width: 4),
          Text(
            'URGENT',
            style: TextStyle(
              fontSize: 13,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
              color: Colors.red[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primaryRedColor,
          child: Text(
            (widget.bulletin.authorName ?? 'RC')[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.bulletin.authorName ?? 'Red Cross Uganda',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C2C2C),
                ),
              ),
              if (widget.bulletin.publishedAt != null)
                Text(
                  dateFormat.format(widget.bulletin.publishedAt!),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Inter",
                    color: Colors.grey[600],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConditionalFields() {
    final fields = <Widget>[];

    // Event fields
    if (widget.bulletin.subtype?.hasDateFields == true) {
      fields.add(_buildEventSection());
    }

    // Emergency/Disaster fields
    if ([
      BulletinSubtype.emergencyAlert,
      BulletinSubtype.disasterUpdate
    ].contains(widget.bulletin.subtype)) {
      fields.add(_buildEmergencySection());
    }

    // Contact fields
    if (widget.bulletin.subtype?.hasContactFields == true) {
      fields.add(_buildContactSection());
    }

    if (fields.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields,
    );
  }

  Widget _buildEventSection() {
    return Card(
      elevation: 0,
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.event, color: Colors.blue[700], size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Event Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (widget.bulletin.eventStartDate != null) ...[
              _buildInfoRow(
                Icons.calendar_today,
                'Date',
                dateFormat.format(widget.bulletin.eventStartDate!),
              ),
              if (widget.bulletin.eventEndDate != null)
                _buildInfoRow(
                  Icons.event_available,
                  'End Date',
                  dateFormat.format(widget.bulletin.eventEndDate!),
                ),
            ],
            if (widget.bulletin.eventLocation != null)
              _buildInfoRow(
                Icons.location_on,
                'Location',
                widget.bulletin.eventLocation!,
              ),
            if (widget.bulletin.eventCapacity != null)
              _buildInfoRow(
                Icons.people,
                'Capacity',
                '${widget.bulletin.eventRegistered ?? 0}/${widget.bulletin.eventCapacity} registered',
              ),
            if (widget.bulletin.requiresRegistration == true &&
                widget.bulletin.registrationUrl != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _launchUrl(widget.bulletin.registrationUrl!),
                  icon: const Icon(Icons.app_registration),
                  label: const Text('Register Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRedColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencySection() {
    return Card(
      elevation: 0,
      color: Colors.red[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.red[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: Colors.red[700], size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Emergency Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (widget.bulletin.severityLevel != null)
              _buildInfoRow(
                Icons.priority_high,
                'Severity',
                widget.bulletin.severityLevel!.toUpperCase(),
              ),
            if (widget.bulletin.affectedArea != null)
              _buildInfoRow(
                Icons.location_city,
                'Affected Area',
                widget.bulletin.affectedArea!,
              ),
            if (widget.bulletin.actionRequired != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.red[900], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Action Required',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.bulletin.actionRequired!,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Inter",
                              color: Colors.red[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Card(
      elevation: 0,
      color: Colors.green[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.green[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.contact_phone, color: Colors.green[700], size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Contact Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (widget.bulletin.contactPerson != null)
              _buildInfoRow(
                Icons.person,
                'Contact Person',
                widget.bulletin.contactPerson!,
              ),
            if (widget.bulletin.contactPhone != null)
              _buildInfoRow(
                Icons.phone,
                'Phone',
                widget.bulletin.contactPhone!,
                isLink: true,
                linkUrl: 'tel:${widget.bulletin.contactPhone}',
              ),
            if (widget.bulletin.contactEmail != null)
              _buildInfoRow(
                Icons.email,
                'Email',
                widget.bulletin.contactEmail!,
                isLink: true,
                linkUrl: 'mailto:${widget.bulletin.contactEmail}',
              ),
            if (widget.bulletin.requestDeadline != null ||
                widget.bulletin.applicationDeadline != null)
              _buildInfoRow(
                Icons.timer,
                'Deadline',
                dateFormat.format(widget.bulletin.requestDeadline ??
                    widget.bulletin.applicationDeadline!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value,
      {bool isLink = false, String? linkUrl}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                isLink && linkUrl != null
                    ? InkWell(
                        onTap: () => _launchUrl(linkUrl),
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Inter",
                            color: AppColors.primaryRedColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    : Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: "Inter",
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tags',
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C2C2C),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.bulletin.tags!
              .map((tag) => Chip(
                    label: Text(
                      tag.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "Inter",
                      ),
                    ),
                    backgroundColor: Colors.grey[200],
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
