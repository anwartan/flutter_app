import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource tvRemoteDataSource;
  TvRepositoryImpl({required this.tvRemoteDataSource});

  @override
  Future<Either<Failure, List<Tv>>> getNowPlayingOnTv() async {
    try {
      final result = await tvRemoteDataSource.getNowPlayingOnTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularOnTv() async {
    try {
      final result = await tvRemoteDataSource.getPopularOnTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await tvRemoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchOnTv(String query) async {
    try {
      final result = await tvRemoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id) async {
    try {
      final result = await tvRemoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Episode>>> getTvEpisodeBySeason(
      int idTv, int idSeason) async {
    try {
      final result =
          await tvRemoteDataSource.getTvEpisodeBySeason(idTv, idSeason);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedOnTv() async {
    try {
      final result = await tvRemoteDataSource.getTvTopRated();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }
}
