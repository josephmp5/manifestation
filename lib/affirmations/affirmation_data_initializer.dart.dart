import 'package:manifestation/affirmations/affirmations_db.dart';

class AffirmationDataInitializer {
  static Future<void> populateAffirmations() async {
    final db = AffirmationDatabase.instance;

    // Predefined affirmations
    final affirmations = [
      "I am capable of achieving great things.",
      "I attract positive energy into my life.",
      "I believe in my ability to succeed.",
      "I am strong, confident, and resilient.",
      "Every day is a new opportunity for growth."
    ];

    for (String affirmation in affirmations) {
      await db.insertAffirmation(
          affirmation); // Use the insert method from AffirmationDatabase
    }
  }
}
