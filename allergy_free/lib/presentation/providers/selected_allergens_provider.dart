import 'package:allergy_free/models/allergy.dart';
import 'package:flutter_riverpod/legacy.dart';

final selectedAllergensProvider = StateProvider<List<Allergy>>((ref) => []);