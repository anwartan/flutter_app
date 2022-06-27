// Mocks generated by Mockito 5.2.0 from annotations
// in watch/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i16;
import 'dart:io' as _i3;
import 'dart:typed_data' as _i17;

import 'package:core/core.dart' as _i8;
import 'package:core/data/datasources/db/database_helper.dart' as _i12;
import 'package:core/data/datasources/watch_local_data_source.dart' as _i10;
import 'package:core/data/models/watch_table.dart' as _i11;
import 'package:core/domain/entities/watch.dart' as _i9;
import 'package:core/domain/repositories/watch_repository.dart' as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter/src/widgets/navigator.dart' as _i14;
import 'package:http/io_client.dart' as _i5;
import 'package:http/src/base_request.dart' as _i15;
import 'package:http/src/response.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i13;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeSecurityContext_1 extends _i1.Fake implements _i3.SecurityContext {}

class _FakeResponse_2 extends _i1.Fake implements _i4.Response {}

class _FakeIOStreamedResponse_3 extends _i1.Fake
    implements _i5.IOStreamedResponse {}

/// A class which mocks [WatchRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchRepository extends _i1.Mock implements _i6.WatchRepository {
  MockWatchRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(_i9.Watch? watch) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [watch]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i9.Watch? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? refId, _i8.Type? type) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [refId, type]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Watch>>> getWatchlist() =>
      (super.noSuchMethod(Invocation.method(#getWatchlist, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Watch>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Watch>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Watch>>>);
}

/// A class which mocks [WatchLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchLocalDataSource extends _i1.Mock
    implements _i10.WatchLocalDataSource {
  MockWatchLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i11.WatchTable? watch) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [watch]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i11.WatchTable? watch) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [watch]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i11.WatchTable?> getWatchByIdAndType(
          int? refId, _i8.Type? type) =>
      (super.noSuchMethod(
              Invocation.method(#getWatchByIdAndType, [refId, type]),
              returnValue: Future<_i11.WatchTable?>.value())
          as _i7.Future<_i11.WatchTable?>);
  @override
  _i7.Future<List<_i11.WatchTable>> getWatchlist() => (super.noSuchMethod(
          Invocation.method(#getWatchlist, []),
          returnValue: Future<List<_i11.WatchTable>>.value(<_i11.WatchTable>[]))
      as _i7.Future<List<_i11.WatchTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i12.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i13.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i13.Database?>.value())
          as _i7.Future<_i13.Database?>);
  @override
  _i7.Future<int> insertWatchlist(_i11.WatchTable? watch) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [watch]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlist(_i11.WatchTable? watch) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [watch]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlist() => (super.noSuchMethod(
      Invocation.method(#getWatchlist, []),
      returnValue: Future<List<Map<String, dynamic>>>.value(
          <Map<String, dynamic>>[])) as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<Map<String, dynamic>?> getWatchByRefIdAndType(
          int? refId, _i8.Type? type) =>
      (super.noSuchMethod(
              Invocation.method(#getWatchByRefIdAndType, [refId, type]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
}

/// A class which mocks [NavigatorObserver].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigatorObserver extends _i1.Mock implements _i14.NavigatorObserver {
  MockNavigatorObserver() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void didPush(
          _i14.Route<dynamic>? route, _i14.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didPush, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didPop(_i14.Route<dynamic>? route, _i14.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didPop, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didRemove(
          _i14.Route<dynamic>? route, _i14.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didRemove, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didReplace(
          {_i14.Route<dynamic>? newRoute, _i14.Route<dynamic>? oldRoute}) =>
      super.noSuchMethod(
          Invocation.method(
              #didReplace, [], {#newRoute: newRoute, #oldRoute: oldRoute}),
          returnValueForMissingStub: null);
  @override
  void didStartUserGesture(
          _i14.Route<dynamic>? route, _i14.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(
          Invocation.method(#didStartUserGesture, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didStopUserGesture() =>
      super.noSuchMethod(Invocation.method(#didStopUserGesture, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [CustomIOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i8.CustomIOClient {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i3.SecurityContext> get globalContext =>
      (super.noSuchMethod(Invocation.getter(#globalContext),
              returnValue:
                  Future<_i3.SecurityContext>.value(_FakeSecurityContext_1()))
          as _i7.Future<_i3.SecurityContext>);
  @override
  _i7.Future<_i4.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i5.IOStreamedResponse> send(_i15.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: Future<_i5.IOStreamedResponse>.value(
                  _FakeIOStreamedResponse_3()))
          as _i7.Future<_i5.IOStreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  _i7.Future<_i4.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i17.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i17.Uint8List>.value(_i17.Uint8List(0)))
          as _i7.Future<_i17.Uint8List>);
}
