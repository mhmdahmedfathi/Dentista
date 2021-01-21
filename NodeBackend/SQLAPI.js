const mysql = require('mysql');

// initialize the connection string
var config =
{
    host: 'dentistastore.mysql.database.azure.com',
    user: 'dentista@dentistastore',
    password: '@dentist1',
    database: 'DENTISTA',
    port: 3306
};

const connecton = new mysql.createConnection(config);

connecton.connect(
    function (err)
    {
        if (err)
        {
            console.log("Cannot Connect, Error is Occured");
            throw err;
        }
        else 
        {
            console.log("Connection Established");

            // To Generate Query
            var res = retriveDentist();
            console.log(res);
        }
    }
);

async function retriveDentist()
{
    await connecton.query( 'SELECT * FROM DENTIST WHERE DENTIST_ID = 1;',
                    function (err, result, fields)
                    {
                        if (err) throw err;
                        else console.log("Retrive is done correctly");
                        for (i = 0; i < result.length; i++)
                        {
                            //console.log('Row: ' + JSON.stringify(result[i]));
                            return JSON.stringify(result[i]);
                        }
                        console.log("Done");
                    }

    );
};

/*
class SQL
{
    constructor(Config = config)
    {
        this.Config = Config; // For Connection String

        this.connector = new mysql.createConnection(this.Config);
        this.isConnected = false;

        this.connector.connect(
            function (err)
            {
                if (err)
                {
                    console.log("Cannot Connect, Error is Occured");
                    throw err;
                }
                else 
                {
                    console.log("Connection Established");
                }
            }

        );
    }

    #EstablishConnection() // Private function to establic mysql Connection
    {

    }
}
*/