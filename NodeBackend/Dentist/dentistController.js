const mysql = require('mysql');


class dentistController
{
    
     constructor()
     {
         // Creating an instance of the Model
        this.dentistModel = new dentistNameSpace.Dentist();
     }

     async insertDentist(request, response) 
      {
           this.dentistModel.setFname = request.body.Dentist_Fname;
           this.dentistModel.setLname = request.body.Dentist_Lname;
           this.dentistModel.setFname = request.body.Dentist_Email;
      }
 
}