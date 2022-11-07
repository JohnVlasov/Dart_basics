import 'dart:math';

// ------------------------------1------------------------------
// Реализуйте методы вычисления НОД и НОК целых чисел. Реализуйте метод, который разбивает число на простые множители и возвращает их.
class DelimetersCalculator {
  // НОД
  int _gcdBasic(int a, int b) {
    if (a < b) {
      int x = a;
      a = b;
      b = x;
    }
    while (b != 0) {
      a %= b;
      int x = a;
      a = b;
      b = x;
    }
    return a;
  }

  // НОД из списка
  int gcd(List<int> args) {
    int res = args[0];
    args.removeAt(0);
    for (int n in args) {
      res = _gcdBasic(res, n);
    }
    return res;
  }

  // НОК
  int _lcmBasic(int a, int b) {
    return (a * b) ~/ _gcdBasic(a, b);
  }

  // НОК из списка
  int lcm(List<int> args) {
    int res = args[0];
    args.removeAt(0);
    for (int n in args) {
      res = _lcmBasic(res, n);
    }
    return res;
  }

  // множители
  List<int> multipliers(int n) {
    List<int> res = [];
    while (n > 1) {
      if (n <= 3) {
        res.add(n);
        break;
      }
      for (int i = 2; i <= n; i++) {
        if (n % i == 0) {
          res.add(i);
          n = n ~/ i;
          break;
        }
      }
    }
    return res;
  }
}

//----------------------------2--------------------------------------
// Реализуйте методы для преобразования целых чисел из десятичной системы в двоичную и обратно.
class RadixCalculator {
  // bin to int
  int binToInt(String b) {
    int res = 0;
    for (int i = 0; i < b.length; i++) {
      res += pow(2, i).toInt() * int.parse(b[b.length - 1 - i]);
    }
    return res;
  }

  // int to bin
  String intToBin(int n) {
    List<String> binList = [];
    do {
      binList.add((n % 2).toString());
      n = n ~/ 2;
    } while (n > 0);
    return binList.reversed.join('');
  }
}

class Words {
  //---------------------------3----------------------------------
  // Реализуйте метод, который принимает строку слов, разделённых пробелами. Задача — найти в данной строке числа и вернуть коллекцию num этих чисел.
  List<num> nums(String s) {
    List<num> res = [];
    for (String word in s.split(' ')) {
      try {
        res.add(num.parse(word));
      } catch (e) {}
    }
    return res;
  }

  //--------------------------4-------------------------------------
  //Есть коллекция слов. Реализуйте метод, возвращающий Map. Данный Map должен соотносить слово и количество его вхождений в данную коллекцию.
  Map<String, int> wordCount(List<String> words) {
    Map<String, int> res = Map();
    for (String w in words) {
      if (res[w] == null) {
        res[w] = 1;
      } else {
        res[w] = res[w]! + 1;
      }
    }
    return res;
  }

  //------------------------------5-------------------------------
  //Есть коллекция строк вида ‘one, two, three, cat, dog’ или любого другого. Реализуйте метод, возвращающий цифры без повторений, которые встречаются в данной строке. Однако цифры встречаются в виде английских слов от zero до nine. Например, в результате строки ‘one, two, zero, zero’ мы получим следующий результат: [1, 2, 0]. Если в строке есть слова, не являющиеся цифрами от 0 до 9, пропускайте их.
  List<int> numbers(String str) {
    Set<int> res = Set();
    Map<String, int> numbers = {'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9};
    for(String w in str.split(',')){
      int? x = (numbers[w.trim().toLowerCase()]);
      if (x != null) res.add(x);
    }
    return res.toList();
  }
}

void main() {
  // test 1
  var calc = DelimetersCalculator();
  print(calc.gcd([10, 40, 15, 90])); // НОД
  print(calc.lcm([10, 40, 200, 44])); // НОК
  print(calc.multipliers(897)); // множители

  //test2
  var rCalc = RadixCalculator();
  print(rCalc.intToBin(255)); // преобразование десятичного числа в двоичное
  print(rCalc.binToInt('11111111')); // преобразование двоичного числа в десятичное

  var words = Words();
  // test3
  print(words.nums('qweqweqw 6qweqwee we 99 qwe 9 qweqwe  qweqeqwe 67.6 76.676 dfdf 12')); // поиск чисел в строке
  // test4
  List<String> ws = ['test', 'test', 'aaa', 'bbb', 'John', 'Bill', 'Petr', 'Petr', 'Bill'];
  print(words.wordCount(ws)); // подсчёт слов

  //test5
  String str = 'one, two, three, cat, dog, two, nine, five, zero';
  print(words.numbers(str)); // поиск чисел в словах
}
