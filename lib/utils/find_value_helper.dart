class FindValueHelper {
  int? findNotCorrectAmount(List<int> numbersList) {
    final isEvenList = _checkEvenList(numbersList);
    if (isEvenList == null) {
      return null;
    }
    for (int i = 0; i < numbersList.length; i++) {
      if (isEvenList && numbersList[i].isOdd) {
        return numbersList[i];
      }
      if (!isEvenList && numbersList[i].isEven) {
        return numbersList[i];
      }
    }
    return null;
  }

  bool? _checkEvenList(List<int> numbersList) {
    var even = 0;
    var odd = 0;
    for (int i = 0; i < numbersList.length; i++) {
      if (numbersList[i].isEven) {
        even++;
      } else {
        odd++;
      }
    }
    if (odd == 1 && even > 1) {
      return true;
    }
    if (even == 1 && odd > 1) {
      return false;
    }
    if (even == odd) {
      return null;
    }
    if (even > 1 && odd > 1) {
      return null;
    }
    return null;
  }
}
