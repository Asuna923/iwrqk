import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/display_util.dart';
import '../../../../../data/models/forum/thread.dart';
import '../../../../../global_widgets/keep_alive_wrapper.dart';
import '../../../../../global_widgets/reloadable_image.dart';
import '../../../../../global_widgets/sliver_refresh/widget.dart';
import '../../../../../routes/pages.dart';
import 'controller.dart';

class ThreadPreviewList extends StatefulWidget {
  final String channelName;
  final ScrollController? scrollController;

  const ThreadPreviewList(
      {super.key, required this.channelName, this.scrollController});

  @override
  State<ThreadPreviewList> createState() => _ThreadPreviewListState();
}

class _ThreadPreviewListState extends State<ThreadPreviewList> {
  late ThreadPreviewListController _controller;

  @override
  void initState() {
    super.initState();
    Get.create(() => ThreadPreviewListController());
    _controller = Get.find<ThreadPreviewListController>();
    _controller.initConfig(widget.channelName);
  }

  Widget _buildThreadPreview({
    required String channelName,
    required ThreadModel thread,
  }) {
    return Card(
      color: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.thread, arguments: {
            'title': thread.title,
            'starterUserName': thread.user.username,
            'channelName': channelName,
            'threadId': thread.id,
            'locked': thread.locked,
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipOval(
                  child: ReloadableImage(
                    imageUrl: thread.user.avatarUrl,
                    width: 40,
                    height: 40,
                  ),
                ),
                title: Text(
                  thread.user.name,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Text(
                  DisplayUtil.getDisplayDate(DateTime.parse(
                      thread.lastPost?.createAt ?? thread.createdAt)),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text.rich(
                  TextSpan(
                    children: [
                      if (thread.locked)
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: FaIcon(
                              FontAwesomeIcons.lock,
                              size: 17.5,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      TextSpan(
                        text: thread.title,
                        style: thread.locked
                            ? Theme.of(context).textTheme.titleMedium?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2.5,
                                )
                            : Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidEye,
                          size: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DisplayUtil.compactBigNumber(thread.numViews),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidComment,
                          size: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DisplayUtil.compactBigNumber(thread.numPosts),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverRefresh(
      controller: _controller,
      scrollController: widget.scrollController,
      builder: (data, reachBottomCallback) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              reachBottomCallback(index);

              return KeepAliveWrapper(
                child: _buildThreadPreview(
                  thread: data[index],
                  channelName: widget.channelName,
                ),
              );
            },
            childCount: data.length,
          ),
        );
      },
    );
  }
}
