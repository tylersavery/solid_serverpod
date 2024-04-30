import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spriver_flutter/core/utils/show_snackbar.dart';
import 'package:spriver_flutter/features/asset/domain/providers/asset_repository_provider.dart';

class UploadImageWidget extends ConsumerWidget {
  final String url;
  final String label;
  final Function(String url) onComplete;

  const UploadImageWidget({
    super.key,
    required this.url,
    required this.onComplete,
    this.label = 'File',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            if (url.isNotEmpty)
              Image.network(
                url,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final image = await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  if (context.mounted) {
                    final result = await ref.read(assetRepositoryProvider).uploadImage(image: image);

                    result.fold((failure) {
                      showSnackBar(context, failure.message);
                    }, (url) {
                      onComplete(url);
                    });
                  }
                }
              },
              child: Text(url.isEmpty ? "Upload" : "Replace"),
            )
          ],
        )
      ],
    );
  }
}
