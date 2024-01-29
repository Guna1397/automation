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

public class MRN_API {

	@Test
	public void fetchTest() throws Exception, Exception {
		RestAssured.baseURI = "https://ds-idev-func-da-mrnsearch.azurewebsites.net";
		RequestSpecification httprequest = RestAssured.given().header("Authorization", "Bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJPcmdJRCI6WyIyLjE2Ljg0MC4xLjExOTM1ODQ3NTkyMy4xIl19.VbWpD6k_5tqLiaAvI3TKcTHRGbDNyB2Cl6Xeo6wqUtQ");		
		Response response = httprequest.request(Method.GET, "/api/mrnsearch?mrn=1742583002");
		String responsebody = response.getBody().asString();
		System.out.println("Response body is " + responsebody);
		int StatusCode = response.getStatusCode();
		Assert.assertEquals(StatusCode, 200);
	}
}