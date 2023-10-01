class ApiUrlConstant{
  static const baseUrl="https://techblog.sasansafari.com/Techblog/api/";
  static const hostDlUrl="https://techblog.sasansafari.com";
  static const getHomeItem="${baseUrl}home/?command=index";
  static const getArticleList="${baseUrl}article/get.php?command=new&user_id=";
  static const publishedByMe="${baseUrl}article/get.php?command=published_by_me&user_id=";
  static const postRegister="${baseUrl}register/action.php";
  static const postArticle="${baseUrl}article/post.php";
}

class ApiKeyConstant{
  static const title="title";
  static const content="content";
  static const catId="cat_id";
  static const tagList="tag_list";
  static const userId="user_id";
  static const image="image";
  static const command="command";
}