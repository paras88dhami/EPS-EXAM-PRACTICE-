import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../core/services/ad_service.dart';

class TestBannerAd extends StatefulWidget {
  const TestBannerAd({super.key});
  @override
  State<TestBannerAd> createState() => _TestBannerAdState();
}
class _TestBannerAdState extends State<TestBannerAd> {
  BannerAd? _ad;
  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
      adUnitId: AdService.bannerTestId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdFailedToLoad: (ad, _) { ad.dispose(); }),
    )..load();
  }
  @override
  void dispose() { _ad?.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => _ad == null
      ? const SizedBox.shrink()
      : SizedBox(width: _ad!.size.width.toDouble(), height: _ad!.size.height.toDouble(), child: AdWidget(ad: _ad!));
}
