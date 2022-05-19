import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/datasources/watch_local_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/repositories/watch_repository.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  TvRepository,
  WatchRepository,
  MovieRepository,
  MovieRemoteDataSource,
  TvRemoteDataSource,
  WatchLocalDataSource,
  DatabaseHelper,
  NavigatorObserver
], customMocks: [
  MockSpec<CustomIOClient>(as: #MockHttpClient)
])
void main() {}
