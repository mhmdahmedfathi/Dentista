class ProductComment
{
  int CommentID;
  String CommentContext;
  int Likes;
  int DentistID;
  String DentistName;
  String DentistImageURL;
  String CommentDate;

  ProductComment(int CommentID, String CommentContext, int Likes, int DentistID, String DentistName, String DentistImageURL, String CommentDate)
  {
    this.CommentID = CommentID;
    this.CommentContext = CommentContext;
    this.Likes = Likes;
    this.DentistID = DentistID;
    this.DentistName = DentistName;
    this.DentistImageURL = DentistImageURL;
    this.CommentDate = CommentDate;
  }
}