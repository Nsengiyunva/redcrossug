class BloodDonationFaq {
  final int id;
  final String question;
  final String answer;
  final String category;
  final int? order;
  final double? relevanceScore;

  BloodDonationFaq({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    this.order,
    this.relevanceScore,
  });

  factory BloodDonationFaq.fromJson(Map<String, dynamic> json) {
    return BloodDonationFaq(
      id: json['id'] as int,
      question: json['question'] as String,
      answer: json['answer'] as String,
      category: json['category'] as String,
      order: json['order'] as int?,
      relevanceScore: json['relevance_score'] != null 
          ? (json['relevance_score'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'category': category,
      'order': order,
      'relevance_score': relevanceScore,
    };
  }
}

class FaqCategory {
  final String key;
  final String label;

  FaqCategory({
    required this.key,
    required this.label,
  });

  factory FaqCategory.fromJson(String key, String label) {
    return FaqCategory(
      key: key,
      label: label,
    );
  }
}
