import 'package:rxdart/rxdart.dart';

extension StreamExtention on Stream {}

/// Constructs a [Stream] which merges the specified [Stream]s into a sequence using the given
/// [zipper] Function, whenever all of the provided [Stream]s have produced
/// an element at a corresponding index.
ZipStream<dynamic, R> zip11<A, B, C, D, E, F, G, H, I, J, K, R>(
  Stream<A> streamA,
  Stream<B> streamB,
  Stream<C> streamC,
  Stream<D> streamD,
  Stream<E> streamE,
  Stream<F> streamF,
  Stream<G> streamG,
  Stream<H> streamH,
  Stream<I> streamI,
  Stream<J> streamJ,
  Stream<K> streamK,
  R Function(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k) zipper,
) {
  return ZipStream<dynamic, R>(
    [
      streamA,
      streamB,
      streamC,
      streamD,
      streamE,
      streamF,
      streamG,
      streamH,
      streamI,
      streamJ,
      streamK,
    ],
    (List<dynamic> values) {
      return zipper(
        values[0] as A,
        values[1] as B,
        values[2] as C,
        values[3] as D,
        values[4] as E,
        values[5] as F,
        values[6] as G,
        values[7] as H,
        values[8] as I,
        values[9] as J,
        values[10] as K,
      );
    },
  );
}

ZipStream<dynamic, R> zip12<A, B, C, D, E, F, G, H, I, J, K, L, R>(
  Stream<A> streamA,
  Stream<B> streamB,
  Stream<C> streamC,
  Stream<D> streamD,
  Stream<E> streamE,
  Stream<F> streamF,
  Stream<G> streamG,
  Stream<H> streamH,
  Stream<I> streamI,
  Stream<J> streamJ,
  Stream<K> streamK,
  Stream<L> streamL,
  R Function(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l) zipper,
) {
  return ZipStream<dynamic, R>(
    [
      streamA,
      streamB,
      streamC,
      streamD,
      streamE,
      streamF,
      streamG,
      streamH,
      streamI,
      streamJ,
      streamK,
      streamL,
    ],
    (List<dynamic> values) {
      return zipper(
        values[0] as A,
        values[1] as B,
        values[2] as C,
        values[3] as D,
        values[4] as E,
        values[5] as F,
        values[6] as G,
        values[7] as H,
        values[8] as I,
        values[9] as J,
        values[10] as K,
        values[11] as L,
      );
    },
  );
}

ZipStream<dynamic, R> zip13<A, B, C, D, E, F, G, H, I, J, K, L, M, R>(
  Stream<A> streamA,
  Stream<B> streamB,
  Stream<C> streamC,
  Stream<D> streamD,
  Stream<E> streamE,
  Stream<F> streamF,
  Stream<G> streamG,
  Stream<H> streamH,
  Stream<I> streamI,
  Stream<J> streamJ,
  Stream<K> streamK,
  Stream<L> streamL,
  Stream<M> streamM,
  R Function(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m)
      zipper,
) {
  return ZipStream<dynamic, R>(
    [
      streamA,
      streamB,
      streamC,
      streamD,
      streamE,
      streamF,
      streamG,
      streamH,
      streamI,
      streamJ,
      streamK,
      streamL,
      streamM,
    ],
    (List<dynamic> values) {
      return zipper(
        values[0] as A,
        values[1] as B,
        values[2] as C,
        values[3] as D,
        values[4] as E,
        values[5] as F,
        values[6] as G,
        values[7] as H,
        values[8] as I,
        values[9] as J,
        values[10] as K,
        values[11] as L,
        values[12] as M,
      );
    },
  );
}
