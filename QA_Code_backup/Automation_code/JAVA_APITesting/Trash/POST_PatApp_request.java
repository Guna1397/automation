package RestAssured.APITesting;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.testng.annotations.Test;
import java.io.FileReader;
import java.io.IOException;
import io.restassured.RestAssured;
import io.restassured.http.Method;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

public class POST_PatApp_request {
	
	@Test
	public void postTest() throws IOException, ParseException {
		
		//baseuri
		JSONParser jsonparser = new JSONParser();
		FileReader reader = new FileReader(".\\testdata\\put_request\\POST_reqpayload.json");
		Object obj = jsonparser.parse(reader);
		JSONObject patdatajsonobj = (JSONObject) obj;
//		RestAssured.baseURI="https://reqres.in/api";
		RestAssured.baseURI = "https://nadsiadlvelysdsperadl.blob.core.windows.net";
//		RestAssured.
		//requestobject, httprequest is a variable, give() is a method which is used to sent req to a server
//		RequestSpecification authrequest=RestAssured.given().header("x-ms-blob-type","BlockBlob");	
//		RequestSpecification httprequest=RestAssured.given().body(patdatajsonobj);	

//		Request payload sending along with post request		

//		httprequest.header("Content-Type", "application/json");
		
		
//		httprequest.header("Content-Type","text/plain");
//		httprequest.header("Accept-Encoding","gzip, deflate, br");
//		httprequest.header("Connection","keep-alive");
		System.out.println(patdatajsonobj);

		RequestSpecification httprequest=RestAssured.given().body(patdatajsonobj);
//		JSONObject requestparams = new JSONObject();
//		System.out.println(requestparams);
		httprequest.given().header("x-ms-blob-type", "BlockBlob").and().header("Content-Type","text/plain");
//		httprequest.body(requestparams.toJSONString());	
		System.out.println("passScript");
		System.out.println(httprequest.log().all());
		
		
		Response response = httprequest.request(Method.PUT,"/docspera-adls/5192ef52-53a5-4d55-8743-09ffff05bfb8.json?sp=racwl&st=2023-05-08T09:01:47Z&se=2023-08-08T17:01:47Z&spr=https&sv=2022-11-02&sr=c&sig=ibHUH+ZZGgMi9ha0FspwDFVoOKPfbfc2QbN3HwYPTB8=");
		//System.out.println(response);		
		String responsebody = response.getBody().asString();
		System.out.print("pass2");
		
		
		System.out.print(responsebody);
		//statuscode validation
		int StatusCode = response.getStatusCode();
		System.out.println("Status code is "+StatusCode);
		//Assert.ass(StatusCode, 200);
//		Assert.assertEquals(StatusCode, 201);		
		//Statusline
		String Statusline = response.getStatusLine();
		System.out.println(Statusline);		
		System.out.println("Test passed"); 
//		JSONParser jsonparser = new JSONParser();
//		FileReader reader = new FileReader(".\\testdata\\testdata.json");
//		Object obj=jsonparser.parse(reader);
//		JSONObject datajsonobj=(JSONObject)obj;
//		String fname=(String) datajsonobj.get("name");
//		String fjob=(String) datajsonobj.get("job");
//		System.out.println(fname);
//		System.out.println(fjob);

	}
	
}
