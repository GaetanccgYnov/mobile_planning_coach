class DaySelectorService {
  Map<String, bool> _daysOfWeek = {
    'Lundi': false,
    'Mardi': false,
    'Mercredi': false,
    'Jeudi': false,
    'Vendredi': false,
    'Samedi': false,
  };

  Map<String, bool> get daysOfWeek => _daysOfWeek;

  void updateDay(String day, bool isSelected) {
    _daysOfWeek[day] = isSelected;
  }
}