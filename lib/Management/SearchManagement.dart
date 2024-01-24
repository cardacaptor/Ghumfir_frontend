import 'package:flutter/material.dart';
import 'package:ghumfir_f/services/RecommendationService.dart';

import '../Models/post_model.dart';

class SearchManagement with ChangeNotifier {
  late TextEditingController controller = TextEditingController()
    ..addListener(() async {
      String searchText = controller.text.trim();
      if (searchText.isNotEmpty) {
        searchResults = await RecommendationService().searchFeed(1, searchText);
        if (searchResults?.isEmpty ?? false) {
          searchResults = null;
        }
      }
      notifyListeners();
    });

  update(PostModel post) {
    if (searchResults == null) return;
    for (int i = 0; i < searchResults!.length; i++) {
      if (searchResults![i].id == post.id) {
        searchResults![i] = post;
        notifyListeners();
        break;
      }
    }
  }

  List<PostModel>? searchResults;
}
