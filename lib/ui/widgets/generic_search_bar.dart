import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Callback type for search queries.
typedef SearchCallback = void Function(String query);

/// Extracts a list of suggestions from a given state.
typedef ExtractSuggestions<T, S> = List<T> Function(S state);

/// Builds a widget for a suggestion item.
typedef SuggestionBuilder<T> = Widget Function(
    BuildContext context, T item, SearchController controller);

/// A generic search bar widget integrated with a BLoC for suggestions.
///
/// This widget provides a search bar that interacts with a BLoC to fetch and display suggestions.
/// It supports debounced search queries and custom suggestion item builders.
class GenericBlocSearchBar<T, BlocType extends BlocBase<StateType>, StateType>
    extends StatefulWidget {
  /// Called when the search query changes.
  final SearchCallback onSearch;

  /// Extracts suggestions from the BLoC state.
  final ExtractSuggestions<T, StateType> extractSuggestions;

  /// Builds a widget for each suggestion item.
  final SuggestionBuilder<T> itemBuilder;

  /// The hint text to display in the search bar.
  final String hintText;

  /// Creates a [GenericBlocSearchBar] widget.
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

/// State for [GenericBlocSearchBar].
///
/// Manages the search controller, debouncing, and builds the UI for suggestions.
class _GenericBlocSearchBarState<T, BlocType extends BlocBase<StateType>,
    StateType> extends State<GenericBlocSearchBar<T, BlocType, StateType>> {
  late final SearchController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  /// Handles debounced search query changes.
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
