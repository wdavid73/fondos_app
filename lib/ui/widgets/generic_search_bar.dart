import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef SearchCallback = void Function(String query);
typedef ExtractSuggestions<T, S> = List<T> Function(S state);
typedef SuggestionBuilder<T> = Widget Function(
    BuildContext context, T item, SearchController controller);

class GenericBlocSearchBar<T, BlocType extends BlocBase<StateType>, StateType>
    extends StatefulWidget {
  final SearchCallback onSearch;
  final ExtractSuggestions<T, StateType> extractSuggestions;
  final SuggestionBuilder<T> itemBuilder;
  final String hintText;

  const GenericBlocSearchBar({
    super.key,
    required this.onSearch,
    required this.extractSuggestions,
    required this.itemBuilder,
    this.hintText = 'Buscar...',
  });

  @override
  State<GenericBlocSearchBar<T, BlocType, StateType>> createState() =>
      _GenericBlocSearchBarState<T, BlocType, StateType>();
}

class _GenericBlocSearchBarState<T, BlocType extends BlocBase<StateType>,
    StateType> extends State<GenericBlocSearchBar<T, BlocType, StateType>> {
  late final SearchController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  void _onQueryChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BlocType>();

    return SearchAnchor(
      searchController: _searchController,
      viewOnChanged: _onQueryChanged,
      builder: (context, controller) => SearchBar(
        controller: controller,
        hintText: widget.hintText,
        onTap: controller.openView,
        leading: const Icon(Icons.search),
      ),
      suggestionsBuilder: (context, controller) {
        return [
          StreamBuilder<StateType>(
            stream: bloc.stream,
            initialData: bloc.state,
            builder: (context, snapshot) {
              final state = snapshot.data;
              if (state == null) {
                return const SizedBox.shrink();
              }

              final suggestions = widget.extractSuggestions(state);
              if (suggestions.isEmpty) {
                return const ListTile(title: Text('No hay sugerencias...'));
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: suggestions
                    .map(
                        (item) => widget.itemBuilder(context, item, controller))
                    .toList(),
              );
            },
          ),
        ];
      },
    );
  }
}
