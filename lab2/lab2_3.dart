void main() {
  List<int> myList = [1, 2, 1, 0, 3, 5, 8, 8, 8, 3, 2, 1];
  List<Set<int>> goodPairs = [];
  
  var len = myList.length;
  for(int i = 0; i < len; i++) {
    for(int j = i; j < len; j++) {
      if(myList[i] == myList[j] && i != j) {
        goodPairs.add({i, j});
      }
    }
  }

  print(goodPairs);
  print(goodPairs.length);
}