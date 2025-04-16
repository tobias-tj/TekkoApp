import 'package:tekko/features/api/data/models/donation.dart';

import '../../domain/repositories/donation_repository.dart';
import '../datasources/donation_remote_datasource.dart';

class DonationRepositoryImpl implements DonationRepository {
  final DonationRemoteDatasource remoteDataSource;

  DonationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> createPaymentIntent(Donation donation) {
    return remoteDataSource.createPaymentIntent(donation);
  }
}
