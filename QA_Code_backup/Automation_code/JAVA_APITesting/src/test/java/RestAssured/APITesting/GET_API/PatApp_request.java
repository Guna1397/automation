package RestAssured.APITesting.GET_API;

import java.io.FileReader;
import java.io.*;
import java.io.IOException;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.junit.Assert;
import org.testng.TestListenerAdapter;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.Listeners;
import org.testng.annotations.Test;
import org.testng.asserts.SoftAssert;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.reporter.*;
import com.test.listeners.APITestListener;

import io.restassured.RestAssured;
import io.restassured.http.Method;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

public class PatApp_request {

	@Test
	public void fetchTest() throws Exception, Exception {
		RestAssured.baseURI = "https://ds-idev-func-da-fhir-api.azurewebsites.net/api/dsep/patient";
		JSONParser jsonparser = new JSONParser();
		FileReader reader = new FileReader(".\\testdata\\get_request\\file.json");
		Object obj = jsonparser.parse(reader);
		JSONObject datajsonobj = (JSONObject) obj;
		RequestSpecification httprequest = RestAssured.given().body(datajsonobj);
		Response response = httprequest.request(Method.GET, "/1dd247d5-db0b-4dc7-92e7-20ab518e13bc");
		String responsebody = response.getBody().asString();
		System.out.println("Response body is " + responsebody);
		int StatusCode = response.getStatusCode();
		Assert.assertEquals(StatusCode, 200);
	}
}
