import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/components/container_appbar.dart';
import 'package:orim/components/drawer_toggle.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/utils/widget/widget.dart';

class ContactPage extends StatefulWidget {
  static const String routeName = 'contact_tab';

  const ContactPage();

  @override
  State<StatefulWidget> createState() {
    return _ContactPageState();
  }
}

class _ContactPageState extends State<ContactPage>
    implements AutomaticKeepAliveClientMixin<ContactPage> {

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DimenResource.paddingContent),
      child: Column(
        children: <Widget>[
          ImageView.asset(ImageResource.contact_banner),
          Text(
            StringResource.getText(context, 'content_contact_tab'),
            style: TextStyle(
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class ContactPageTabbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const ContactPageTabbar({
    Key key,
    this.height = DimenResource.heightTabbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      isLightStatus: true,
      child: AppBar(
        leading: DrawerToggle(),
        title: TitleContainer(
          titleText: StringResource.getText(context, 'title_contact_tab'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
