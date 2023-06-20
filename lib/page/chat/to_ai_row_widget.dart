import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:markdown_widget/widget/markdown.dart';

import '../../util/theme_utils.dart';



class ToAiRowWidget extends StatefulWidget {
  const ToAiRowWidget({super.key});
  @override
  State<ToAiRowWidget> createState() => _ToAiRowWidgetState();
}



class _ToAiRowWidgetState extends State<ToAiRowWidget> {


  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: BoxConstraints(minHeight: 90.h,minWidth: double.infinity),
      color: ThemeUtils.getThemeColor(context),
      padding: EdgeInsets.only(top: 15.h,bottom: 15.h,left: 100.w,right: 100.w),
      child: Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.only(right: 20.w,),
            child:  ClipOval(
              child: Image.network(
                "https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints(minHeight: 90.h),
              child: MarkdownWidget(
                data: 'a',
                shrinkWrap:true,
                physics: new NeverScrollableScrollPhysics(),
              ),
            ),
          ),
          Container(
            width: 100.w,
            height: 50,
            child: Row(
              children: [
                Container(
                  child: Icon(Icons.copy),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

String a = '''

# I'm h1
## I'm h2
### I'm h3
#### I'm h4
###### I'm h5
###### I'm h6

```
class MarkdownHelper {


  Map<String, Widget> getTitleWidget(m.Node node) => title.getTitleWidget(node);

  Widget getPWidget(m.Element node) => p.getPWidget(node);

  Widget getPreWidget(m.Node node) => pre.getPreWidget(node);

}
```


*italic text*

**strong text**

`I'm code`

~~del~~

***~~italic strong and del~~***

> Test for blockquote and **strong**


- ul list
- one
    - aa *a* a
    - bbbb
        - CCCC

1. ol list
2. aaaa
3. bbbb
    1. AAAA
    2. BBBB
    3. CCCC


[I'm link](https://github.com/asjqkkkk/flutter-todos)


- [ ] I'm *CheckBox*

- [x] I'm *CheckBox* too

Test for divider(hr):

---

Test for Table:

header 1 | header 2
---|---
row 1 col 1 | row 1 col 2
row 2 col 1 | row 2 col 2

Image:

![support](assets/script_medias/1675527935336.png)

Image with link:

[![pub package](assets/script_medias/1675527938945.png)](https://pub.dartlang.org/packages/markdown_widget)

Html Image:

<img width="250" height="250" src="assets/script_medias/1675527939855.png"/>

Video:

<video src="http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4">



''';
