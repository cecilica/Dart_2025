/*
  Write a function that takes a string and a list of regular expressions as parameters
  and returns a list of strings that match at least one of the given regular expressions.
*/

List<String> matchStrings(String str, List<RegExp> regExps) {
  List<String> solutions = [];

  // for each regular expression, find all matches in the string
  for (RegExp regExp in regExps) {
    // allMatches returns an iterable of Match objects, which we itarate over and add the matched string to the solutions list
    var matches = regExp.allMatches(str);
    for (var match in matches) {
      solutions.add(match.group(0)!);
    }
  }

  // remove empty strings from the solutions list
  solutions.removeWhere((solution) => solution.isEmpty);

  return solutions;
}

void main() {
  String myString = "Hello Helllloo World ab12 12ab";
  // a list of regular expressions, each string is mapped to a RegExp object
  List<RegExp> myRegExps = ["Hi", "Hel*o", ".*", "[a-z]{5}", "^H.*", " .*2\$"]
      .map((str) => RegExp(str))
      .toList();

  print(matchStrings(myString, myRegExps));
}