import 'package:flutter/material.dart';
import 'package:student_hub_flutter/widgets/loading_view.dart';

class RefreshableFutureBuilder<T> extends StatefulWidget {
  static RefreshableFutureBuilder<Iterable<T>> forCollection<T>({
    Key? key,
    required Future<Iterable<T>> Function() fetcher,
    required Widget Function(BuildContext context, Iterable<T> data) builder,
    String emptyString = "No item left"
  }) {
    return RefreshableFutureBuilder(
      fetcher: fetcher,
      builder: (context, data) {
        if (data.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                emptyString,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return builder(context, data);
      }
    );
  }

  final Widget? childWidget;
  final Widget Function(BuildContext context, T data)? childBuilder;
  final Future<T> Function() fetcher;

  const RefreshableFutureBuilder({
    super.key,
    required this.fetcher,
    required Widget Function(BuildContext context, T data) builder
  }) :
    childBuilder = builder,
    childWidget = null;

  const RefreshableFutureBuilder.widget({
    super.key,
    required this.fetcher,
    required Widget child
  }) :
    childWidget = child,
    childBuilder = null;

  @override
  State<RefreshableFutureBuilder> createState() => _RefreshableFutureBuilderState<T>();
}

class _RefreshableFutureBuilderState<T> extends State<RefreshableFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.fetcher(),
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
      return const LoadingView();
    }

    if (snapshot.connectionState == ConnectionState.none || (snapshot.data == null && null is! T)) {
      return RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text("There's a problem fetching data. Please try again"),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () => setState(() {}),
              child: const Text("Retry")
            )
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => setState(() {}),
      child: widget.childBuilder?.call(context, snapshot.data) ?? widget.childWidget!
    );
  }
}