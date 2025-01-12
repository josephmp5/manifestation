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
      // Show the popup with a progress indicator immediately
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SizedBox(
              height: 150,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );

      try {
        // Fetch the generated image URL from the API
        String? imageUrl = await ImageApi().generateImage(prompt);

        // Close the progress indicator dialog
        Navigator.pop(context);

        // If an image URL is retrieved, display it in the popup
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
          // Show an error message if no image URL is returned
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to generate image. Please try again.'),
              ),
            );
          }
        }
      } catch (e) {
        // Close the progress dialog if an error occurs
        Navigator.pop(context);
        // Show an error message
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
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add a header or text above the grid
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Click your manifestations to get visulization',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  // Wrap both GridView and Create Manifest section in Expanded
                  Expanded(
                    child: Column(
                      children: [
                        // GridView now takes 80% of the available space
                        Expanded(
                          flex: 8, // This takes 80% of the available space
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: manifestations.length,
                            itemBuilder: (context, index) {
                              final manifest = manifestations[index];
                              return GestureDetector(
                                onTap: () => generateImage(manifest),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: const Color(0xFF6495ED),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        manifest,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Create Manifest section takes 20% of the available space
                        Expanded(
                          flex: 2, // This takes 20% of the available space
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Create Manifest",
                                style: TextStyle(color: Color(0xFFA52A2A)),
                              ),
                              const SizedBox(height: 4),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: CreateManifest(),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
