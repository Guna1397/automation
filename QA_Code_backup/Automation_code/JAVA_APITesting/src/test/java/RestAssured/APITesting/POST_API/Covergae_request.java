package RestAssured.APITesting.POST_API;

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


public class Covergae_request {

	@Test
	public void postTest() throws IOException, ParseException {
		JSONParser jsonparser = new JSONParser();
		FileReader reader = new FileReader("./testdata/put_request/POST_reqpayload.json");
//		System.out.println(reader);
		Object obj = jsonparser.parse(reader);
		System.out.println("poiuytre");
		JSONObject patdatajsonobj = (JSONObject) obj;
		System.out.println("poiuytre");
		System.out.println(patdatajsonobj);
		RestAssured.baseURI = "https://nadsiadlvelysdsperadl.blob.core.windows.net";
		System.out.println(patdatajsonobj);
		RequestSpecification httprequest = RestAssured.given().body(patdatajsonobj);
		httprequest.given().header("x-ms-blob-type", "BlockBlob").and().header("Content-Type", "text/plain");
		System.out.println("passScript");
		System.out.println(httprequest.log().all());
		Response response = httprequest.request(Method.PUT,
				"/docspera-adls/9992ef52-53a5-4d55-8743-09ffff05bfb8.json?sp=racwl&st=2023-05-08T09:01:47Z&se=2023-08-08T17:01:47Z&spr=https&sv=2022-11-02&sr=c&sig=ibHUH+ZZGgMi9ha0FspwDFVoOKPfbfc2QbN3HwYPTB8=");
		String responsebody = response.getBody().asString();
		System.out.print("pass2");
		System.out.print(responsebody);
		int StatusCode = response.getStatusCode();
		System.out.println("Status code is " + StatusCode);
		String Statusline = response.getStatusLine();
		System.out.println(Statusline);
		System.out.println("Test passed");
	}
}
