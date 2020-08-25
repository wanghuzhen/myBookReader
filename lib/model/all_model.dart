//分类结果
class Classification {
  final String classifyUrl;
  final String classification;

  Classification(this.classifyUrl, this.classification);
}

//热门书籍
class HostBook {
  final String bookUrl;
  final String bookTitle;

  HostBook(this.bookUrl, this.bookTitle);
}

//搜索书籍项目
class BookSearchItem {
  //书名
  final String bookName;
  //图书地址
  final String bookUrl;
  //作者
  final String author;
  //最新章节url
  final String lastUrl;
  //最新章节标题
  final String lastTitle;
  //文章类型
  final String type;
  //图书封面
  final String bookCover;
  //最新章节更新时间
  final String time;

  BookSearchItem(this.bookName, this.bookUrl, this.author, this.lastUrl,
      this.lastTitle, this.type, this.bookCover, this.time);
}

//分类书籍项目
class BookClassifyItem {
  //图书地址
  final String bookUrl;
  //书名
  final String bookName;
  //图书封面
  final String bookCover;
  //作者
  final String author;
  //作者作品列表url
  final String authorBookList;
  //书籍介绍
  final String intro;
  //最新章节url
  final String lastUrl;
  //最新章节标题
  final String lastTitle;

  BookClassifyItem(
    this.bookUrl,
    this.bookName,
    this.bookCover,
    this.author,
    this.authorBookList,
    this.intro,
    this.lastUrl,
    this.lastTitle,
  );
}

//书籍介绍
class BookIntro {
  //图书地址
  final String bookUrl;
  //书名
  final String bookName;
  //图书封面
  final String bookCover;
  //作者
  final String author;
  //最新章节url
  final String lastUrl;
  //最新章节标题
  final String lastTitle;
  //书籍介绍
  final String intro;
  //来源
  final String coming;
  //更新时间
  final String time;
  //章节数目
  final int characterNum;
  //目录
  final List<String> dirList;

  BookIntro(
      this.bookUrl,
      this.bookName,
      this.bookCover,
      this.author,
      this.lastUrl,
      this.lastTitle,
      this.intro,
      this.coming,
      this.time,
      this.characterNum, this.dirList);
}
