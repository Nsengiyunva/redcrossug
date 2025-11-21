class MediaFile {
  final int id;
  final String fileUrl;
  final String fileType;
  final bool isImage;

  MediaFile({
    required this.id,
    required this.fileUrl,
    required this.fileType,
    required this.isImage,
  });

  factory MediaFile.fromJson(Map<String, dynamic> json) {
    return MediaFile(
      id: json['id'] ?? 0,
      fileUrl: json['file_url'] ?? '',
      fileType: json['file_type'] ?? '',
      isImage: json['is_image'] ?? false,
    );
  }
}
