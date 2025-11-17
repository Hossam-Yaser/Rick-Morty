import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic/cubit/charachters_cubit.dart';
import '../../constants/appcolors.dart';
import '../../data/models/charachters_model.dart';
import '../widgets/buildnointernet_widget.dart';
import '../widgets/charachter_item.dart';

class CharachtersScreen extends StatefulWidget {
  const CharachtersScreen({super.key});

  @override
  State<CharachtersScreen> createState() => _CharachtersScreenState();
}

class _CharachtersScreenState extends State<CharachtersScreen> {
  List<CharachterModel> allCharacters = [];
  List<CharachterModel> filteredCharacters = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: Appcolors.mainGrey,
      decoration: InputDecoration(
        hintText: "Search for character ......",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Appcolors.mainGrey, fontSize: 18),
      ),
      style: TextStyle(color: Appcolors.mainGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemToFilterdList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemToFilterdList(String searchedCharacter) {
    filteredCharacters = allCharacters
        .where(
          (charachter) =>
              charachter.name.toLowerCase().startsWith(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: Appcolors.mainGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearch();
          },
          icon: Icon(Icons.search, color: Appcolors.mainGrey),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return AnimatedTextKit(
      repeatForever: true,

      animatedTexts: [
        ScaleAnimatedText(
          'Characters',
          textStyle: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Appcolors.mainGrey,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<CharachtersCubit>().getAllCharachters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.darkSaga,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        centerTitle: true,
        leading: _isSearching
            ? BackButton(color: Appcolors.mainGrey)
            : Container(),
        shadowColor: Appcolors.saga,
        elevation: 1,
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected = !connectivity.contains(
                ConnectivityResult.none,
              );
              if (connected) {
                return BlocBuilder<CharachtersCubit, CharachtersState>(
                  builder: (context, state) {
                    if (state is CharachtersLoaded) {
                      allCharacters = state.charachters;
                      return buildCharactersGrid();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Appcolors.darkSaga,
                        ),
                      );
                    }
                  },
                );
              } else {
                return builNoInternet();
              }
            },
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildCharactersGrid() {
    return SingleChildScrollView(
      child: Container(
        color: Appcolors.mainGrey,
        child: GridView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: _searchTextController.text.isNotEmpty
              ? filteredCharacters.length
              : allCharacters.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemBuilder: (_, index) {
            return CharachterItem(
              charachter: _searchTextController.text.isNotEmpty
                  ? filteredCharacters[index]
                  : allCharacters[index],
            );
          },
        ),
      ),
    );
  }
}
