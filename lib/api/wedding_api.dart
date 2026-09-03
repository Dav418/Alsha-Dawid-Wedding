import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/strapi_config.dart';
import '../models/content/content.dart';
import '../models/strapi/strapi_response.dart';
import '../models/vendors/vendor_item.dart';

part 'wedding_api.g.dart';

class WeddingApi {
  WeddingApi(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> getWeddingJson() async {
    final response = await _dio.get<Map<String, dynamic>>(
      StrapiConfig.wedding,
      queryParameters: {
        'populate': '*',
      },
    );

    return StrapiSingleResponse<Map<String, dynamic>>.fromJson(
      response.data!,
      (json) => json,
    ).data;
  }

  Future<List<WeddingPartyMember>> getWeddingPartyMembers() async {
    final response = await _dio.get<Map<String, dynamic>>(
      StrapiConfig.weddingPartyMembers,
      queryParameters: {
        'populate': '*',
        'pagination[pageSize]': 100,
        'sort[0]': 'role:asc',
        'sort[1]': 'sortOrder:asc',
      },
    );

    return StrapiCollectionResponse<WeddingPartyMember>.fromJson(
      response.data!,
      WeddingPartyMember.fromJson,
    ).data;
  }

  Future<List<WeddingFoodItem>> getFoodItems() async {
    final response = await _dio.get<Map<String, dynamic>>(
      StrapiConfig.foodItems,
      queryParameters: {
        'populate': '*',
        'pagination[pageSize]': 100,
        'sort[0]': 'culture:asc',
        'sort[1]': 'sortOrder:asc',
      },
    );

    return StrapiCollectionResponse<WeddingFoodItem>.fromJson(
      response.data!,
      WeddingFoodItem.fromJson,
    ).data;
  }

  Future<List<OurStoryPhoto>> getStoryEntries() async {
    final response = await _dio.get<Map<String, dynamic>>(
      StrapiConfig.storyEntries,
      queryParameters: {
        'populate': '*',
        'pagination[pageSize]': 100,
        'sort[0]': 'sortOrder:asc',
      },
    );

    return StrapiCollectionResponse<OurStoryPhoto>.fromJson(
      response.data!,
      OurStoryPhoto.fromJson,
    ).data;
  }

  Future<List<VendorItem>> getVendors() async {
    final response = await _dio.get<Map<String, dynamic>>(
      StrapiConfig.vendors,
      queryParameters: {
        'populate': '*',
        'pagination[pageSize]': 100,
        'sort[0]': 'sortOrder:asc',
      },
    );

    return StrapiCollectionResponse<VendorItem>.fromJson(
      response.data!,
      VendorItem.fromJson,
    ).data;
  }
}

@riverpod
class WeddingDio extends _$WeddingDio {
  @override
  Dio build() {
    return Dio(
      BaseOptions(
        baseUrl: StrapiConfig.baseUrl,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
  }
}

@riverpod
class WeddingApiService extends _$WeddingApiService {
  @override
  WeddingApi build() {
    return WeddingApi(ref.watch(weddingDioProvider));
  }
}
