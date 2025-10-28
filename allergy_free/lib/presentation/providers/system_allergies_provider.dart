import 'package:allergy_free/database/database_operations.dart';
import 'package:allergy_free/models/allergy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final systemAllergiesProvider = FutureProvider<List<Allergy>>((ref) {
  return DatabaseOperations().getSystemAllergies();
});
