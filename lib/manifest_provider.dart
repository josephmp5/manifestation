import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manifestation/manifestation_repository.dart';

final manifestationProvider =
    StateNotifierProvider<ManifestationNotifier, List<String>>(
  (ref) => ManifestationNotifier(),
);

class ManifestationNotifier extends StateNotifier<List<String>> {
  final _repository = ManifestationRepository();

  ManifestationNotifier() : super([]) {
    _loadManifestations();
  }

  // Load saved manifestations on app startup
  Future<void> _loadManifestations() async {
    final savedData = await _repository.loadManifestations();
    state = savedData;
  }

  // Add a new manifestation and save it locally
  Future<void> addManifestation(String manifest) async {
    state = [...state, manifest];
    await _repository.saveManifestations(state);
  }

  // Remove a manifestation and update local storage
  Future<void> removeManifestation(String manifest) async {
    state = state.where((item) => item != manifest).toList();
    await _repository.saveManifestations(state);
  }

  // Clear all manifestations and local storage
  Future<void> clearManifestations() async {
    state = [];
    await _repository.saveManifestations(state);
  }
}
