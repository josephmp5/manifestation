import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manifestation/image_api.dart';
import 'package:manifestation/manifest_provider.dart';
import 'package:manifestation/pages/create_manifest.dart';
import 'package:page_transition/page_transition.dart';

class Manifest extends ConsumerWidget {
  const Manifest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manifestations = ref.watch(manifestationProvider);

    void generateImage(String prompt) async {
      // Fetch the generated image URL from the API
      String? imageUrl = await ImageApi().generateImage(prompt);

      // Show the image in a popup dialog
      if (imageUrl != null && context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(imageUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to generate image. Please try again.'),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Your Manifestations')),
      body: manifestations.isEmpty
          ? const Center(child: Text('No manifestations yet. Start creating!'))
          : ListView.builder(
              itemCount: manifestations.length,
              itemBuilder: (context, index) {
                final manifest = manifestations[index];
                return ListTile(
                  title: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: const Color(0xFF6495ED),
                    child: Column(
                      children: [
                        Text(manifest),
                      ],
                    ),
                  ),
                  subtitle: GestureDetector(
                    onTap: () {
                      generateImage(manifest);
                    },
                    child: const Text('Get the visualization'),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(manifestationProvider.notifier)
                          .removeManifestation(manifest);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: CreateManifest(),
              type: PageTransitionType.rightToLeftWithFade,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
