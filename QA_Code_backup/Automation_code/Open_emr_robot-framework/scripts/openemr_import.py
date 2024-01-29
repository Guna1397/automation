import mysql.connector

def queryExecuter(uname):
    mydb = mysql.connector.connect(
    host="dev-dsp-emr-server.mysql.database.azure.com",
    user="dspadmin@dev-dsp-emr-server",
    password="dspopenemr@123",
    database="openemr",
    autocommit=True
    )

    mycursor = mydb.cursor()

    #sql = "DELETE FROM d4c_fhir_datastore.device WHERE id NOT IN (1588,1589,1590)"
    sql_del = f"SELECT fname,lname FROM openemr.users where username='{uname}'"
    mycursor.execute(sql_del,multi=True)
    #mydb.commit()
    myresult = mycursor.fetchall()
    for x in myresult:
        return x
    mydb.close()