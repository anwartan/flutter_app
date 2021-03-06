// Mocks generated by Mockito 5.2.0 from annotations
// in watch/test/presentation/cubit/watch_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:core/domain/entities/watch.dart' as _i8;
import 'package:core/domain/repositories/watch_repository.dart' as _i2;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:watch/domain/get_watchlist.dart' as _i10;
import 'package:watch/domain/get_watchlist_status.dart' as _i4;
import 'package:watch/domain/remove_watchlist.dart' as _i9;
import 'package:watch/domain/save_watchlist.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeWatchRepository_0 extends _i1.Fake implements _i2.WatchRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatus extends _i1.Mock
    implements _i4.GetWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WatchRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeWatchRepository_0()) as _i2.WatchRepository);
  @override
  _i5.Future<bool> execute(int? id, _i6.Type? type) =>
      (super.noSuchMethod(Invocation.method(#execute, [id, type]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [SaveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlist extends _i1.Mock implements _i7.SaveWatchlist {
  MockSaveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WatchRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeWatchRepository_0()) as _i2.WatchRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i8.Watch? watch) =>
      (super.noSuchMethod(Invocation.method(#execute, [watch]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlist extends _i1.Mock implements _i9.RemoveWatchlist {
  MockRemoveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WatchRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeWatchRepository_0()) as _i2.WatchRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i8.Watch? watch) =>
      (super.noSuchMethod(Invocation.method(#execute, [watch]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [GetWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlist extends _i1.Mock implements _i10.GetWatchlist {
  MockGetWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i8.Watch>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i8.Watch>>>.value(
              _FakeEither_1<_i6.Failure, List<_i8.Watch>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i8.Watch>>>);
}
