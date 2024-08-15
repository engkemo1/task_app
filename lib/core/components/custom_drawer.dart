import 'package:flutter/material.dart';
import 'package:task/core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasIconBack;
 final void Function()? onTapMenu;
 final void Function()? onTapAction;
  final String title;
  final IconData? iconData;
  final String? subtitle;
  final String? actionText;

  CustomAppBar({
    required this.hasIconBack,
    required this.title,
     this.subtitle,
    this.actionText, this.onTapMenu, this.iconData, this.onTapAction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(

      leading: hasIconBack
          ? IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )

          : null,

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 5),
          if(subtitle!=null)// Space between title and subtitle
          Text(
            subtitle!,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              fontSize: 15,
            ),
          ),
        ],
      ),
      actions: [
        actionText == null
            ? const SizedBox.shrink()
            : InkWell(
          onTap: onTapAction,
              child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
                        ),
                        child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(iconData!=null)
                  Icon(iconData,color: AppColors.pinColor,),
                  const SizedBox(width: 5,),
                  Text(actionText!,style: const TextStyle(color: AppColors.pinColor),),
                ],
              ),
                        ),
                      ),
            ),
      ],
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
