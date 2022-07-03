import 'package:flutter/material.dart';
import 'package:memorable/domain/model/user.dart';

class OnboardingProvider extends ChangeNotifier {
  User _user = User.unknownUser();

  void setGender(Gender gender) {
    _user = _user.copyWith(
      gender: gender
    );

    notifyListeners();
  }

  void setMarried(bool? isMarried) {
    _user = _user.copyWith(
        isMarried: isMarried
    );

    notifyListeners();
  }

  void setTheNumberOfChildren(int? numOfChildren) {
    _user = _user.copyWith(
        numOfChildren: numOfChildren
    );

    notifyListeners();
  }
}
