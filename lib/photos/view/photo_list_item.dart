part of 'photos_view.dart';

class _PhotoListItem extends StatelessWidget {
  const _PhotoListItem({required this.jsonplaceholder});

  final Jsonplaceholder jsonplaceholder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          context.read<PhotoDetailsBloc>().add(PhotoSelected(jsonplaceholder));
          Navigator.of(context).pushNamed(Navigation.photosDetailRoute);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: jsonplaceholder.thumbnailUrl,
                placeholder: (BuildContext context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              jsonplaceholder.title,
              style: Theme.of(context).textTheme.titleMedium,
            )),
          ],
        ),
      ),
    );
  }
}
