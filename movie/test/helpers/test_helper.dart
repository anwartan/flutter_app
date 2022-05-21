

import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/watch_local_data_source.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/watch_repository.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([

  WatchRepository,
  MovieRepository,
  MovieRemoteDataSource,

  WatchLocalDataSource,
  DatabaseHelper,
  NavigatorObserver
], customMocks: [
  MockSpec<CustomIOClient>(as: #MockHttpClient)
])
void main() {}
