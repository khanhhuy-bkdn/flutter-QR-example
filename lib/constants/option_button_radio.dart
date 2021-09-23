enum OptionButtonRadio { month, date }

extension ParseToString on OptionButtonRadio {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
