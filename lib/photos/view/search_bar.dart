part of 'photos_view.dart';

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                key: const Key("SearchBar"),
                onChanged: (value) {
                  context
                      .read<PhotoBloc>()
                      .add(FilterRequested(searchInput: value));
                },
                decoration: const InputDecoration(
                  hintText: "Search by title",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
