# Git新建分支的方法

> 以从anno分支创建一个新的分支的方法

## 更新项目

> 新旧版UI的界面、操作可能不同，但是大致的操作基本一致（旧版UI的分支信息应该是在窗口的右下角开启）

![image-20230609221149151](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609221149151.png)

查看打开了项目页面的左上角，有项目的一些信息，其中最右边的`v2`是当前正在使用的分支，点击`v2`右边的箭头，我们可以看到更多关于这个项目的分支。

![image-20230609221320238](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609221320238.png)

在这里，你们可能还不能看到今晚新建的分支，因为还没对项目进行更新，我们点击`update Project`来从云端更新我们的项目，此时下面的`Remote Branched`中应该就会出现新创建的分支`anno`了。

![image-20230609221411932](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609221411932.png)



## 从`anno`分支新建分支

点击`anno`分支右边的箭头，我们可以看到更多的菜单选项

![image-20230609221713506](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609221713506.png)

在这里，我们选择`New Branch from 'origin/anno'...`

![image-20230609221814587](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609221814587.png)

接下来，为自己的新分支命名（可以使用自己的姓名缩写命名），然后点击`Create`来创建自己的分支。

![image-20230609221859468](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609221859468.png)

创建完毕后，打开项目结构，可以看到这个结构已经是与`anno`中一致的了，接下来所作的更改均在自己的分支上进行。![image-20230609222127135](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609222127135.png)



## 修改并上传分支

由于我们新创建的分支还是在本地，我们需要将新的分支推送到云端。

首先我们先做一点修改，比如在`README.md`文档的最后添加上自己的姓名。![image-20230609223334688](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609223334688.png)

再次打开以下页面，点击`commit`，会打开一个新的提交界面

![image-20230609223430787](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609223430787.png)

在文件预览框中勾选上自己想要提交的文件（同时，在下方`Diff`框中，可以看到自己的更改），并且在`Commit Message`框中输入提交信息（必备），然后点击`Commit`按钮

![image-20230609223654597](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609223654597.png)

接下来右下角弹出![image-20230609223908997](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609223908997.png)说明提交成功了。

但是，当前的提交还只是在本地，我们还需要将我们新建的分支和新作的更改提交到github的仓库中，接下来，我们就要进行`push`的操作，来将我们在本地所作的更改提交到github仓库中去。

> 注意：这个过程可能需要科学上网。

再次打开以下页面，选择`Push`

![image-20230609224101997](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609224101997.png)

接下来出现一个界面，点击`Push`按钮即可![image-20230609224220852](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609224220852.png)

出现![image-20230609224240686](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609224240686.png)说明已经`Push`成功了

此时，打开Github，就可以看到我们刚刚所作的提交了![image-20230609224350014](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609224350014.png)

切换到该分支后，我们也可以看到，我们所作的修改也提交到github上了![image-20230609224447493](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609224447493.png)

> 注意：接下来，你们所作的所有代码更改和提交，均在自己的分支上进行，而不是直接写在主分支上，然后在主分支提交了。



## 结束

到此，分支的创建和提交就完成了，后续的更改就无须再创建分支了，直接将更改提交到自己的分支上即可。

你们接下来的工作是改写所有的`Tool`，所有的目录按照原来的`Tool`结构进行（以创建包的形式，区别每一类的工具）![image-20230609225207057](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20230609225207057.png)

每个人的分工不重复，最后进行整合、测试。

