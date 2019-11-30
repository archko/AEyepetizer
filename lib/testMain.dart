import 'dart:async';

void main() {
  //testTask();
  //testFuture1();
  testFuture2();
}

void testTask() {
  print('main #1 of 2');
  scheduleMicrotask(() => print('microtask #1 of 3'));

  new Future.delayed(
      new Duration(seconds: 1), () => print('future #1 (delayed)'));

  new Future(() => print('future #2 of 4'))
      .then((_) => print('future #2a'))
      .then((_) {
    print('future #2b');
    scheduleMicrotask(() => print('microtask #0 (from future #2b)'));
  }).then((_) => print('future #2c'));

  scheduleMicrotask(() => print('microtask #2 of 3'));

  new Future(() => print('future #3 of 4'))
      .then((_) => new Future(() => print('future #3a (a new future)')))
      .then((_) => print('future #3b'));

  new Future(() => print('future #4 of 4')).then((_) {
    new Future(() => print('future #4a'));
  }).then((_) => print('future #4b'));
  scheduleMicrotask(() => print('microtask #3 of 3'));
  print('main #2 of 2');
}

testFuture1() {
  print('Before the Future');
  Future(() {
    print('Running the Future');
  }).then((_) {
    print('Future is complete');
  });
  print('After the Future');
}

testFuture2() async {
  //A,'B start',C start from B,C end from B,B end,
  // C running Future from B,C end of Future from B.
  // C start from main,C end from main,D
  // C running Future from main,C end of Future from main.
  methodA();
  await methodB();
  await methodC('main');
  methodD();
}

methodA() {
  print('A');
}

methodB() async {
  print('B start');
  await methodC('B');
  print('B end');
}

methodC(String from) async {
  print('C start from $from');

  Future(() {
    // <== 该代码将在未来的某个时间段执行
    print('C running Future from $from');
  }).then((_) {
    print('C end of Future from $from');
  });

  print('C end from $from');
}

methodD() {
  print('D');
}
