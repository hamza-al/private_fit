// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openfoodfacts/model/Attribute.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:private_fit/domain/open_food/product_image_data.dart';
import 'package:private_fit/l10n/l10n.dart';
import 'package:private_fit/presentation/open_food/product_cards/design_constants.dart';
import 'package:private_fit/presentation/open_food/product_cards/open_food_card.dart';

String getProductName(Product product, AppLocalizations appLocalizations) =>
    product.productName ?? appLocalizations.app_title;

/// Padding to be used while building the SmoothCard on any Product card.
const EdgeInsets SMOOTH_CARD_PADDING =
    EdgeInsets.symmetric(horizontal: 12, vertical: 4);

/// A SmoothCard on Product cards using default margin and padding.
Widget buildProductSmoothCard({
  Widget? header,
  required Widget body,
  EdgeInsets? padding = EdgeInsets.zero,
  EdgeInsets? margin = const EdgeInsets.symmetric(
    horizontal: SMALL_SPACE,
  ),
}) {
  return OpenFoodCard(
    margin: margin,
    padding: padding,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (header != null) header,
        body,
      ],
    ),
  );
}

// used to be in now defunct `AttributeListExpandable`
List<Attribute> getPopulatedAttributes(
  final Product product,
  final List<String> attributeIds,
  final List<String> excludedAttributeIds,
) {
  final result = <Attribute>[];
  final attributes = product.getAttributes(attributeIds);
  for (final attributeId in attributeIds) {
    if (excludedAttributeIds.contains(attributeId)) {
      continue;
    }
    var attribute = attributes[attributeId];
// Some attributes selected in the user preferences
// might be unavailable for some products
    if (attribute == null) {
      continue;
    } else if (attribute.id == Attribute.ATTRIBUTE_ADDITIVES) {
      final additiveNames = product.additives?.names;
      attribute = Attribute(
        id: attribute.id,
        title: attribute.title,
        iconUrl: attribute.iconUrl,
        descriptionShort: additiveNames == null ? '' : additiveNames.join(', '),
      );
    }
    result.add(attribute);
  }
  return result;
}

Widget addPanelButton(
  final String label, {
  final IconData? iconData,
  required final Function() onPressed,
}) =>
    SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(iconData ?? Icons.add),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: ROUNDED_BORDER_RADIUS,
            ),
          ),
        ),
        label: Text(label),
        onPressed: onPressed,
      ),
    );

List<ProductImageData> getAllProductImagesData(
  Product product,
  AppLocalizations appLocalizations,
) {
  final allProductImagesData = <ProductImageData>[
    ProductImageData(
      imageField: ImageField.FRONT,
      imageUrl: product.imageFrontUrl,
      title: appLocalizations.app_title,
      buttonText: appLocalizations.app_title,
    ),
    ProductImageData(
      imageField: ImageField.INGREDIENTS,
      imageUrl: product.imageIngredientsUrl,
      title: appLocalizations.app_title,
      buttonText: appLocalizations.app_title,
    ),
    ProductImageData(
      imageField: ImageField.NUTRITION,
      imageUrl: product.imageNutritionUrl,
      title: appLocalizations.app_title,
      buttonText: appLocalizations.app_title,
    ),
    ProductImageData(
      imageField: ImageField.PACKAGING,
      imageUrl: product.imagePackagingUrl,
      title: appLocalizations.app_title,
      buttonText: appLocalizations.app_title,
    ),
    ProductImageData(
      imageField: ImageField.OTHER,
      title: appLocalizations.app_title,
      buttonText: appLocalizations.app_title,
    ),
  ];
  return allProductImagesData;
}
