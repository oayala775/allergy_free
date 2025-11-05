import 'package:flutter_riverpod/legacy.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

final recognizedTextProvider = StateProvider<List<TextBlock>>((ref) => []);