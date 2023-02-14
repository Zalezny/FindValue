int? findNotCorrectAmount(List<int> numbersList) {
  final isEvenList = checkEvenList(numbersList);
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

bool? checkEvenList(List<int> numbersList) {
  var even = 0;
  var odd = 0;
  for (int i = 0; i < numbersList.length; i++) {
    if (numbersList[i].isEven) {
      even++;
    } else {
      odd++;
    }
    if (even >= 2) {
      return true;
    }
    if (odd >= 2) {
      return false;
    }
  }
  return false;
}
