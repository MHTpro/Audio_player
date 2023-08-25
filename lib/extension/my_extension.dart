//Convert Duration to other things...
extension Durations on Duration {
  String toHoursMinutes() {
    String twoDigitMinutes = _toTwoDigits(
      inMinutes.remainder(60),
    );
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes";
  }

  String toHoursMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(
      inMinutes.remainder(60),
    );
    String twoDigitSeconds = _toTwoDigits(
      inSeconds.remainder(60),
    );
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String toMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(
      inMinutes.remainder(60),
    );
    String twoDigitSeconds = _toTwoDigits(
      inSeconds.remainder(60),
    );
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}
