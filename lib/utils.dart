String convertToDaysPL(int dayIndex) {
  if (dayIndex == 1) return "Poniedziałek";
  if (dayIndex == 2) return "Wtorek";
  if (dayIndex == 3) return "Środa";
  if (dayIndex == 4) return "Czwartek";
  if (dayIndex == 5) return "Piątek";
  if (dayIndex == 6) return "Sobota";
  if (dayIndex == 7) return "Niedziela";
  return "";
}

String convertToMonthsPL(int monthIndex) {
  if (monthIndex == 1) return "Styczeń";
  if (monthIndex == 2) return "Luty";
  if (monthIndex == 3) return "Marzec";
  if (monthIndex == 4) return "Kwiecień";
  if (monthIndex == 5) return "Maj";
  if (monthIndex == 6) return "Czerwiec";
  if (monthIndex == 7) return "Lipiec";
  if (monthIndex == 8) return "Sierpień";
  if (monthIndex == 9) return "Wrzesień";
  if (monthIndex == 10) return "Październik";
  if (monthIndex == 11) return "Listopad";
  if (monthIndex == 12) return "Grudzień";
  return "";
}
