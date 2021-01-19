namespace dentistNameSpace
{
    export class Dentist {
        private DentistID: number;
        private FirstName: string;
        private LastName: string;
        private Email: string;
        private PassWord: string;
        private PhoneNumber: string;
        private Address: string;
        private Area: string;
        private ZipCode: number;
        private CreditCardNumber: string;
    
    
        constructor() {
            // Initialize Dentist Attributes
            this.DentistID = -1;
            this.FirstName = "";
            this.LastName = "";
            this.Email = "";
            this.PassWord = "";
            this.PhoneNumber = "";
            this.Address = "";
            this.Area = "";
            this.CreditCardNumber = "";
            this.ZipCode = -1;
        }
    
        // i- Setters:
        public set setDentistID(dentistID: number) { this.DentistID = dentistID; }
        public set setFname(fname: string) { this.FirstName = fname; }
        public set setLname(lname: string) { this.LastName = lname; }
        public set setEmail(email: string) { this.Email = email; }
        public set setPassword(password: string) { this.PassWord = password; }
        public set setPhoneNumber(phoneNumber: string) { this.PhoneNumber = phoneNumber; }
        public set setAddress(address: string) { this.Address = address; }
        public set setArea(area: string) { this.Area = area; }
        public set setCreditCardNumber(creditCardNumber: string) { this.CreditCardNumber = creditCardNumber; }
        public set setZipCode(zipCode: number) { this.ZipCode = zipCode; }
    
        // ii- Getters:
        public get getFname(): string { return this.FirstName };
        public get getLname(): string { return this.LastName };
        public get getEmail(): string { return this.Email };
        public get getPassword(): string { return this.PassWord };
        public get getPhoneNumber(): string { return this.PhoneNumber };
        public get getAddress(): string { return this.Address };
        public get getArea(): string { return this.Area };
        public get getCreditCardNumber(): string { return this.CreditCardNumber };
        public get getZipCode(): number { return this.ZipCode };
    
    
    }
}