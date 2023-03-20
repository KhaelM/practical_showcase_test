import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_showcase_test/photo_details/bloc/photo_details_bloc.dart';

class PhotoDetailsView extends StatelessWidget {
  const PhotoDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    context.read<PhotoDetailsBloc>().state.jsonplaceholder!.url,
                placeholder: (BuildContext context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "Title:",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    context
                        .read<PhotoDetailsBloc>()
                        .state
                        .jsonplaceholder!
                        .title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "Id:",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    context
                        .read<PhotoDetailsBloc>()
                        .state
                        .jsonplaceholder!
                        .id
                        .toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "Url:",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    context.read<PhotoDetailsBloc>().state.jsonplaceholder!.url,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "Thumbnail url:",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    context
                        .read<PhotoDetailsBloc>()
                        .state
                        .jsonplaceholder!
                        .thumbnailUrl,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "Album id:",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    context
                        .read<PhotoDetailsBloc>()
                        .state
                        .jsonplaceholder!
                        .id
                        .toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
