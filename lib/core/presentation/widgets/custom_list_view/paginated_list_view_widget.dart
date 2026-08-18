import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core.dart';

//ignore: must_be_immutable
class PaginatedListView<T> extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int? page, bool forceReload) onPaginate;
  // PaginatedList<T>? paginatedList;
  final Widget? Function(BuildContext, int) ?itemView;
  final Widget? customView;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final bool enabledPagination;
  final int totalPages;
  final EdgeInsets ?padding;
  final int pageNumber;
  final List<T>? items;
  final ScrollPhysics? scrollPhysics;
  const PaginatedListView({
    super.key,
    this.scrollPhysics,
    this.customView,
    this.padding,
    required this.scrollController,
    required this.onPaginate,
    // required this.paginatedList,
     this.itemView,
    this.enabledPagination = true,
    this.separatorBuilder,
    this.totalPages = 1,
    this.pageNumber = 1,
    this.items,
  });

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // final int? totalPages = (widget.paginatedList?.totalPages);
    // widget.scrollController.addListener(() {
    //   if (widget.scrollController.position.pixels ==
    //           widget.scrollController.position.maxScrollExtent &&
    //       totalPages != null &&
    //       !_isLoading &&
    //       widget.enabledPagination) {
    //     if (mounted) {
    //       _paginate();
    //     }
    //   }
    // });

    widget.scrollController.addListener(() {
      // if (!widget.scrollController.hasClients) return;
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent &&
          !_isLoading &&
          widget.enabledPagination) {
        if (mounted) {
          _paginate();
        }
      }
    });
  }

  void _paginate() async {
    final int totalPages = (widget.totalPages);
    final int pageNumber = (widget.pageNumber);
    if (kDebugMode) {
      print("====>offset==> $pageNumber/ $totalPages");
    }
    if (pageNumber < totalPages) {
      setState(() {
        _isLoading = true;
      });
      await widget.onPaginate((pageNumber) + 1, false);
      setState(() {
        _isLoading = false;
      });
    } else {
      if (_isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child:
              widget.customView ??
              ListView.separated(
                controller: widget.scrollController,
            physics:
                widget.scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: widget.padding??EdgeInsets.zero,
            itemBuilder: widget.itemView!,
            separatorBuilder:
                widget.separatorBuilder ??
                (context, index) {
                  return const SizedBox();
                },
            itemCount: (widget.items??[]).length,
          ),
        ),
        Center(
          child: Padding(
            padding:
                (_isLoading)
                    ? const EdgeInsets.all(AppDimensions.paddingSizeSmall)
                    : EdgeInsets.zero,
            child: _isLoading ? const CustomLoading() : const SizedBox(),
          ),
        ),
      ],
    );
  }
}
