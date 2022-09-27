import 'package:blockie_app/models/nft_info.dart';


class NftLoadInfo{
  final String? nextPageUrl;
  final List<NftInfo> nfts;

  const NftLoadInfo({
    required this.nextPageUrl,
    required this.nfts
  });
}