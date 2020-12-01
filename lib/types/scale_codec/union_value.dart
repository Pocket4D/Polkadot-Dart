class UnionValue<T> {
  int index;
  T value;

  UnionValue(int index, T value) {
    if (index < 0) {
      throw "Index cannot be negative number: $index";
    }
    if (index > 255) {
      throw "Union can have max 255 values. Index: $index";
    }
    this.index = index;
    this.value = value;
  }

  int getIndex() {
    return index;
  }

  T getValue() {
    return value;
  }
}
