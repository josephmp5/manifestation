import 'package:flutter/material.dart';
import 'package:manifestation/affirmations/affirmations_db.dart';

class Affirmations extends StatefulWidget {
  const Affirmations({super.key});

  @override
  State<Affirmations> createState() => _AffirmationsState();
}

class _AffirmationsState extends State<Affirmations> {
  late Future<List<String>> _affirmations;

  @override
  void initState() {
    super.initState();
    _affirmations = fetchAffirmations();
  }

  Future<List<String>> fetchAffirmations() async {
    return await AffirmationDatabase.instance.getAffirmations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Affirmations")),
      body: FutureBuilder<List<String>>(
        future: _affirmations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading affirmations."));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No affirmations available."));
          } else {
            final affirmations = snapshot.data!;
            return PageView.builder(
              itemCount: affirmations.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      affirmations[index],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
