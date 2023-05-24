import 'package:flutter/foundation.dart';

class GlobalState extends ChangeNotifier {
  String? _panelistId;
  String? _selectedGender;
  String? _age;
  String? _ethnicity;
  String? _race;
  String? _blueberryConsumption;
  String? _selectedSample;
  int? _appearance;
  int? _overall;
  String? _posFeedback;
  String? _negFeedback;
  int? _texture;
  int? _flavor;
  double? _sweetness;
  double? _sourness;
  double? _firmness;
  double? _juiciness;
  double? _overallFlavor;
  int? _currSample = 1;
  String? _textureClass;

  String? get panelistId => _panelistId;
  String? get selectedGender => _selectedGender;
  String? get age => _age;
  String? get ethnicity => _ethnicity;
  String? get race => _race;
  String? get blueberryConsumption => _blueberryConsumption;
  String? get selectedSample => _selectedSample;
  int? get appearance => _appearance;
  int? get overall => _overall;
  String? get posFeedback => _posFeedback;
  String? get negFeedback => _negFeedback;
  int? get texture => _texture;
  int? get flavor => _flavor;
  double? get sweetness => _sweetness;
  double? get sourness => _sourness;
  double? get firmness => _firmness;
  double? get juiciness => _juiciness;
  double? get overallFlavor => _overallFlavor;
  int? get currSample => _currSample;
  String? get textureClass => _textureClass;

  set panelistId(String? value) {
    _panelistId = value;
    notifyListeners();
  }

  set selectedGender(String? value) {
    _selectedGender = value;
    notifyListeners();
  }

  set age(String? value) {
    _age = value;
    notifyListeners();
  }

  set ethnicity(String? value) {
    _ethnicity = value;
    notifyListeners();
  }

  set race(String? value) {
    _race = value;
    notifyListeners();
  }

  set blueberryConsumption(String? value) {
    _blueberryConsumption = value;
    notifyListeners();
  }

  set selectedSample(String? value) {
    _selectedSample = value;
    notifyListeners();
  }

  set appearance(int? value) {
    _appearance = value;
    notifyListeners();
  }

  set overall(int? value) {
    _overall = value;
    notifyListeners();
  }

  set posFeedback(String? value) {
    _posFeedback = value;
    notifyListeners();
  }

  set negFeedback(String? value) {
    _negFeedback = value;
    notifyListeners();
  }

  set texture(int? value) {
    _texture = value;
    notifyListeners();
  }

  set flavor(int? value) {
    _flavor = value;
    notifyListeners();
  }

  set sweetness(double? value) {
    _sweetness = value;
    notifyListeners();
  }

  set sourness(double? value) {
    _sourness = value;
    notifyListeners();
  }

  set firmness(double? value) {
    _firmness = value;
    notifyListeners();
  }

  set juiciness(double? value) {
    _juiciness = value;
    notifyListeners();
  }

  set overallFlavor(double? value) {
    _overallFlavor = value;
    notifyListeners();
  }

  set currSample(int? value) {
    _currSample = value;
    notifyListeners();
  }

  set textureClass(String? value) {
    _textureClass = value;
    notifyListeners();
  }

}
