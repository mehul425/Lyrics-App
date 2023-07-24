import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:juna_bhajan/view/common/no_image_view.dart';

class CommonCachedNetworkImageView extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final double radius;
  final BoxShape shape;

  const CommonCachedNetworkImageView({
    required this.height,
    required this.width,
    required this.imageUrl,
    required this.radius,
    this.shape = BoxShape.circle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl.isEmpty
        ? NoImageView(
            height: height,
            width: width,
            radius: radius,
          )
        : ExtendedImage.network(
            imageUrl,
            height: height,
            width: width,
            fit: BoxFit.cover,
            shape: shape,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            loadStateChanged: (state) {
              switch (state.extendedImageLoadState) {
                case LoadState.loading:
                  return NoImageView(
                    height: height,
                    width: width,
                    radius: radius,
                  );
                case LoadState.completed:
                  return ExtendedRawImage(
                    image: state.extendedImageInfo?.image,
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  );
                case LoadState.failed:
                  return NoImageView(
                    height: height,
                    width: width,
                    radius: radius,
                  );
              }
            },
          );
  }
}

class CommonCachedNetworkImageView1 extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final double radius;

  const CommonCachedNetworkImageView1({
    required this.height,
    required this.width,
    required this.imageUrl,
    required this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl.isEmpty
        ? NoImageView(
            height: height,
            width: width,
            radius: radius,
          )
        : CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => NoImageView(
              height: height,
              width: width,
              radius: radius,
            ),
            errorWidget: (context, url, error) => NoImageView(
              height: height,
              width: width,
              radius: radius,
            ),
          );
  }
}
