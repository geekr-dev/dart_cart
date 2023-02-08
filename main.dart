//定义元数据类
class Metadata {
  late String name;
  late double price;
  Metadata(this.name, this.price);
}

// 抽象的打印类，用于打印信息
abstract class Printer {
  printInfo() => print(getInfo());
  getInfo();
}

//定义商品Item类
class Item extends Metadata {
  Item(name, price) : super(name, price);
  Item operator +(Item item) {
    // 重载+运算符，实现套餐商品
    return Item(name + item.name, price + item.price);
  }
}

//定义购物车类
class ShoppingCart extends Metadata with Printer {
  late DateTime date;
  late String? code;
  late List<Item> bookings;

  double get price =>
      bookings.reduce((value, element) => value + element).price;

  // 不带优惠码的构造函数
  ShoppingCart({name}) : this.withCode(name: name, code: null);
  // 使用语法糖和初始化列表进行赋值，并调用父类构造函数
  ShoppingCart.withCode({name, this.code})
      : date = DateTime.now(),
        super(name, 0.0);

  getInfo() => '''
购物车信息:
-----------------------------  
用户名: $name
优惠码: ${code ?? '无'}
总价: $price
日期: $date
-----------------------------
''';
}

void main() {
  ShoppingCart sc1 = ShoppingCart.withCode(name: '张三', code: '123456')
    ..bookings = [Item('苹果', 10.0), Item('鸭梨', 20.0)]
    ..printInfo();

  ShoppingCart sc2 = ShoppingCart(name: '李四')
    ..bookings = [Item('香蕉', 30.0), Item('西瓜', 40.0)]
    ..printInfo();
}
