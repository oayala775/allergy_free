import 'package:allergy_free/models/user.dart';
import 'package:flutter_riverpod/legacy.dart';

final userProvider = StateProvider<User>((ref) => User.empty());