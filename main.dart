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
  List<int> numbers(List<String> words) {
    Set<int> res = Set();
    Map<String, int> numbers = {'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9};
    for (String w in words) {
      int? x = (numbers[w.trim().toLowerCase()]);
      if (x != null) res.add(x);
    }
    return res.toList();
  }
}

//-------------------------------6----------------------------------------\
//Реализуйте класс Point, который описывает точку в трёхмерном пространстве. У данного класса реализуйте метод distanceTo(Point another),
// который возвращает расстояние от данной точки до точки в параметре.
// По желанию можете реализовать метод, принимающий три точки в трёхмерном пространстве и возвращающий площадь треугольника,
// который образуют данные точки. Реализуйте factory-конструкторы для данного класса, возвращающие начало координат,
// и ещё несколько на своё усмотрение (например, конструктор, возвращающий точку с координатами [1,1,1],
// которая определяет единичный вектор).
class Point {
  final int x;
  final int y;
  final int z;

  Point(this.x, this.y, this.z);

  factory Point.zero() {
    return Point(0, 0, 0);
  }

  factory Point.one() {
    return Point(1, 1, 1);
  }

  // расстояние между точками
  double distanceTo(Point another) {
    double res;
    res = sqrt(pow((this.x - another.x), 2) + pow((this.y - another.y), 2) + pow((this.z - another.z), 2));
    return res;
  }

  // площадь треугольника
  static double space(Point p1, Point p2, Point p3) {
    double res;
    double sideA = p1.distanceTo(p2);
    double sideB = p2.distanceTo(p3);
    double sideC = p3.distanceTo(p1);
    double p = (sideA + sideB + sideC) / 2;
    res = sqrt(p * (p - sideA) * (p - sideB) * (p - sideC));
    return res;
  }
}

// -----------------------------7----------------------------------
//Реализуйте метод, который вычисляет корень любой заданной степени из числа. Реализуйте данный метод как extension-метод для num.
// Алгоритм можете взять на википедии как «Алгоритм нахождения корня n-й степени». Запрещается использовать методы math.
// В случае когда значение вернуть невозможно, необходимо бросать исключение с описанием ошибки.
extension on num {
  double root(int n) {
    try {
      double res = this / n;
      double eps = 0.00001; // точность

      while ((this - res._pow(n)).abs() >= eps) {
        res = (1 / n) * ((n - 1) * res + this / res._pow(n - 1));
      }
      return res;
    } catch (e) {
      throw e;
    }
  }

  double _pow(int n) {
    double res = 1;
    for (int i = 0; i < n; i++) {
      res *= this;
    }
    return res;
  }
}

//-------------------------------------8-------------------------------------------
//Создайте класс User, у которого есть поле email. Реализуйте два наследника данного класса AdminUser и GeneralUser.
// Реализуйте mixin над классом User, у которого будет метод getMailSystem, который возвращает значение из email,
// которое находится после @. Например, если email пользователя user@mail.ru, то данный метод вернёт mail.ru.
// Используйте данный миксин на AdminUser. Далее реализуйте класс UserManager<T extends User>, у которого будет храниться список
// пользователей и будут методы добавления или удаления их. Также в UserManager реализуйте метод, который выведет почту
// всех пользователей, однако если пользователь admin, будет выведено значение после @. Проверьте реализованные методы на практике.

class User {
  String email;

  User(this.email);
}

class AdminUser extends User with Domain {
  AdminUser(String email) : super(email);
}

class GeneralUser extends User with Domain {
  GeneralUser(String email) : super(email);
}

mixin Domain on User {
  String getMailSystem() {
    return email.split('@').last;
  }
}

class UserManager<T extends User> {
  List<T> users;

  UserManager(this.users);

  void add(T user) {
    users.add(user);
  }

  void remove(T user) {
    users.remove(user);
  }

  void removeByEmail(String email) {
    for (T user in users) {
      if (user.email == email) {
        users.remove(user);
        break;
      }
    }
  }

  List<String> getAllEmail() {
    List<String> res = [];
    String email;

    for (T user in users) {
      if (user is AdminUser) {
        email = user.getMailSystem();
      } else {
        email = user.email;
      }
      res.add(email);
    }
    return res;
  }
}
//------------------------------------9---------------------------------------------
//Реализуйте метод, который вычисляет значение определённого интеграла Римана в заданных значениях и с заданной точностью разбиения.
// По возможности учтите случаи, когда функция имеет точки разрыва. Реализованный метод должен принимать функцию, точки x1 и x2,
// точность разбиения.

//------------------------------------10----------------------------------------------
//Реализуйте метод, который принимает коэффициенты системы линейных уравнений (для любого числа неизвестных).
// Данный метод создаёт матрицу коэффициентов, приводит её к треугольному виду и находит все неизвестные данной системы.

void main() {
  // test 1
  var calc = DelimetersCalculator();
  print('test1 НОД: ${calc.gcd([10, 40, 15, 90])}'); // НОД
  print('test1 НОК: ${calc.lcm([10, 40, 200, 44])}'); // НОК
  print('test1 множители: ${calc.multipliers(897)}'); // множители

  //test2
  var rCalc = RadixCalculator();
  print('test2 двоичное число: ${rCalc.intToBin(255)}'); // преобразование десятичного числа в двоичное
  print('test2 десятичное число: ${rCalc.binToInt('11111111')}'); // преобразование двоичного числа в десятичное

  var words = Words();
  // test3
  print('test3 найдены числа: ${words.nums('qweqweqw 6qweqwee we 99 qwe 9 qweqwe  qweqeqwe 67.6 76.676 dfdf 12')}'); // поиск чисел в строке
  // test4
  List<String> ws = ['test', 'test', 'aaa', 'bbb', 'John', 'Bill', 'Petr', 'Petr', 'Bill'];
  print('test4 клоичество слов: ${words.wordCount(ws)}'); // подсчёт слов

  //test5
  List<String> str = ['one', 'two', 'three', 'cat', 'dog', 'two', 'nine', 'five', 'zero'];
  print('test5 Обнаружены числа: ${words.numbers(str)}'); // поиск чисел в словах

  //test6
  Point p1 = Point(0, 9, 9);
  Point p2 = Point(10, 10, 10);
  Point p3 = Point.one();
  print('test6 Расстояние между точками: ${p1.distanceTo(p2)}'); // рассотяние между точками
  print('test6 Площадь треугольника: ${Point.space(p1, p2, p3)}'); // площаль треугольника между 3 точками

  //test7
  print('test7 корень : ${1024.root(10)}'); // поиск корня n(10) степени из num (1024)

  //test8
  // создаём пользователей
  AdminUser adminYandex= AdminUser('admin@yandex.ru');
  AdminUser adminGoogle = AdminUser('admin@gmail.com');
  User user1 = User('user1@mail.ru');
  User user2 = User('user2@mail.ru');
  User user3 = User('user3@mail.ru');

  // создаём менеджера и добавляем пользователей
  UserManager manager = UserManager([adminGoogle]);
  manager.add(user1);
  manager.add(user2);
  print('test8 список добавленных пользователей: ${manager.users}');

  // удаляем пользователей из менеджера
  manager.remove(user1);
  manager.removeByEmail('admin@gmail.com');
  print('test8 список оставшихся после удаления пользователей: ${manager.users}');

  manager.add(user3);
  manager.add(adminYandex);
  manager.getAllEmail();
  print('test8 список email: ${manager.getAllEmail()}'); // получаем список email-ов


  //test9
  print('test9 ${'в сад! И причём здесь dart и flutter? Хотите сказать что такие задания помогают лучше освоить Dart?'}');

  //test10
  print('test10 ${'в сад!'}');
}
