class DentistProduct
{
    int ProductID;
    String ProductName;
    String Category;
    String Description;
    String Brand;
    int Price;
    String ImageURL;
    int Rate ;
    int NoOfReviews ;
    int Discount ;

    DentistProduct(int ProductID, String ProductName, String Category, String Description, String Brand, int Price, String ImageURL, int Rate, int NoOfReviews, int Discount)
    {
      this.ProductID = ProductID;
      this.ProductName = ProductName;
      this.Category = Category;
      this.Description = Description;
      this.Brand = Brand;
      this.Price = Price;
      this.ImageURL = ImageURL;
      this.Rate = Rate;
      this.NoOfReviews = NoOfReviews;
      this.Discount = Discount;
    }

}