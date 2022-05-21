

import 'package:core/core.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  TvRepository,

  MovieRepository,

], customMocks: [
  MockSpec<CustomIOClient>(as: #MockHttpClient)
])
void main() {}
