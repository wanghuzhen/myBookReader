//分类结果
class Classification {
  final String classifyUrl;
  final String classification;

  Classification(this.classifyUrl, this.classification);
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

  BookSearchItem(this.author, this.lastUrl, this.lastTitle, this.type,
      this.bookCover, this.bookName, this.bookUrl);
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

  BookClassifyItem(this.bookUrl,this.bookName, this.bookCover, this.author, this.authorBookList, this.intro, this.lastUrl, this.lastTitle,);
}
