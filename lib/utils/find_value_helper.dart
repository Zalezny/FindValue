class FindValueHelper {
  int? findNotCorrectAmount(List<int> numbersList) {
    int even = 0;
    int odd = 0;
    int elementOdd = 0;
    int elementEven = 0;
    for (int i = 0; i < numbersList.length; i++) {
      if (numbersList[i].isEven) {
        even++;
        if (even == 1) {
          elementEven = numbersList[i];
        }
      } else {
        odd++;
        if (odd == 1) {
          elementOdd = numbersList[i];
        }
      }
    }
    if (odd == 1 && even > 1) {
      return elementOdd;
    }
    if (even == 1 && odd > 1) {
      return elementEven;
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
