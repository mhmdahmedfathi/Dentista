import 'package:credit_card_number_validator/credit_card_number_validator.dart';
class Validator
{
  bool validate_name(String name)
  {
    bool valid = true;
    for (int i=0; i < name.length; i++)
    {
      int char = name.codeUnitAt(i);
      if (!((char >= 65 && char <=90)||(char >= 97 && char <= 122)))
      {
        valid = false;
        break;
      }
    }
    return valid;
  }

  bool credit_card_valid(String CreditCard)
  {
    Map<String, dynamic> cardData = CreditCardValidator.getCard(CreditCard);
    String cardType = cardData[CreditCardValidator.cardType];
    bool isValid = cardData[CreditCardValidator.isValidCard];
    return isValid;
  }



  bool validate_password(String password)
  {
    bool special_character = false;
    bool numbers = false;
    bool capical_character = false;
    bool small_character = false;
    bool password_length = false;
    if (password.length >= 6)
    {
      password_length = true;
    }
    for (int i=0; i < password.length; i++)
    {
      var C = password[i];

      int c_val = password.codeUnitAt(i);
      //print(c_val);
      if (c_val >= 65 && c_val <=90)
      {
        capical_character = true;
      }
      if(c_val >= 97 && c_val <= 122)
      {
        small_character = true;
      }
      if (c_val >= 48 && c_val <= 57)
      {
        numbers = true;
      }
      if (c_val >=58 && c_val <=64)
      {
        special_character = true;
      }
    }
    return special_character && numbers && small_character && capical_character && password_length;
    //return true;
  }
}