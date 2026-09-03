import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../api/wedding_api.dart';
import '../../models/vendors/vendor_item.dart';

part 'vendors_repository.g.dart';

@riverpod
class VendorsRepository extends _$VendorsRepository {
  @override
  Future<List<VendorItem>> build() {
    return ref.watch(weddingApiServiceProvider).getVendors();
  }
}
