import 'package:flutter/material.dart';
import 'package:private_fit/presentation/open_food/category_cards/abstract_cache.dart';
import 'package:private_fit/presentation/open_food/category_cards/asset_cache_helper.dart';
import 'package:private_fit/presentation/open_food/category_cards/raster_async_asset.dart';

/// Widget that displays a png/jpeg from network (and cache while waiting).
class RasterCache extends AbstractCache {
  const RasterCache(
    super.iconUrl, {
    super.key,
    super.width,
    super.height,
    super.displayAssetWhileWaiting = true,
  });

  @override
  Widget build(BuildContext context) {
    final fullFilenames = getCachedFilenames();
    if (fullFilenames.isEmpty) {
      return getDefaultUnknown();
    }
    return Image.network(
      iconUrl!,
      width: width,
      height: height,
      fit: BoxFit.contain,
      loadingBuilder: (
        final BuildContext context,
        final Widget child,
        final ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }
        return displayAssetWhileWaiting
            ? RasterAsyncAsset(
                AssetCacheHelper(
                  fullFilenames,
                  iconUrl!,
                  width: width,
                  height: height,
                ),
              )
            : getCircularProgressIndicator();
      },
    );
  }
}
