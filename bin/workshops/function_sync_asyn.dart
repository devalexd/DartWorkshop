/* Synchronous vs. Asynchronous
 * Link: https://dart.dev/codelabs/async-await#why-asynchronous-code-matters
 * - synchronous operation:
 *  A synchronous operation blocks other operations from executing until it completes.
 * - synchronous function:
 *  A synchronous function only performs synchronous operations.
 * - asynchronous operation:
 *  Once initiated, an asynchronous operation allows other operations to execute before it completes.
 * - asynchronous function:
 *  An asynchronous function performs at least one asynchronous operation and can also perform synchronous operations.
 */

/* Option 1: async-await, try-catch-finally
 */
Future<String> createOrderMessage() async {
  try {
    final order = await fetchUserOrder();
    final store = await fetchUserStore();
    return 'Your order is: $order. Please pick up at $store store.';
  } catch (err) {
    return 'Caught error: $err';
  }
}

/* Option 2: Future chaining, .then(cb, onError) | .catchError(cb) | whenComplete(doSomething)
 */
Future<String> createOrderMessageCurry() async {
  return await Future.wait([fetchUserOrder(), fetchUserStore()]) // [order, store]
    .then((valuesList) => 'Your order is: ${valuesList[0]}. Please pick up at ${valuesList[1]} store.')
    .catchError((err) => 'Caught error: $err');
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is
    // more complex and slow.
    Future.delayed(
      const Duration(seconds: 1),
      () => 'Large Latte',
    );

Future<String> fetchUserStore() async {
  return Future.delayed(
    const Duration(seconds: 1),
    () => 'Palo Alto'
  );
}

num counter = 0;
// Using generics type - declare the generics right after function name.
Future<T> performanceLogger<T>(Future<T> Function() cb) async {
  print('Number $counter of trying started:');
  final num timeStart = DateTime.now().millisecondsSinceEpoch;
  final T res = await cb();
  final num timeEnd = DateTime.now().millisecondsSinceEpoch;
  print('Number $counter of trying finished! Time elapsed in milliseconds: ${timeEnd - timeStart}');
  counter += 1;
  return res;
}

Future<void> main() async {
  print('Fetching user order...');
  print(await performanceLogger(createOrderMessage));
  print(await performanceLogger(createOrderMessageCurry));
}
