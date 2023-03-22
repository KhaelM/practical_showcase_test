part of 'photos_view.dart';

class _BottomLoader extends StatelessWidget {
  const _BottomLoader();

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key("BottomLoader"),
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
