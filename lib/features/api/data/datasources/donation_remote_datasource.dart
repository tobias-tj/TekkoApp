import 'package:dio/dio.dart';
import 'package:tekko/features/api/data/models/donation.dart';
import 'package:tekko/features/core/constants/api_constants.dart';

class DonationRemoteDatasource {
  final Dio dio;

  DonationRemoteDatasource({required this.dio});

  Future<String> createPaymentIntent(Donation donation) async {
    final response = await dio.post(ApiConstants.stripePaymentIntent, data: {
      'amount': donation.amount,
      'currency': donation.currency,
      'fullName': donation.fullName,
      'email': donation.email
    });

    return response.data['clientSecret'];
  }
}
