import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manifestation/manifest_provider.dart';

class CreateManifest extends ConsumerWidget {
  final TextEditingController titleController = TextEditingController();

  CreateManifest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Create Manifest',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(230, 0, 0, 0),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your manifestation here',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    final manifest = titleController.text.trim();
                    if (manifest.isNotEmpty) {
                      ref
                          .read(manifestationProvider.notifier)
                          .addManifestation(manifest);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Create')),
            ],
          ),
        ),
      ),
    );
  }
}
