package RestAssured.APITesting.POST_API;

import java.io.FileReader;

import java.io.IOException;
import java.util.UUID;
import java.io.FileWriter;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.testng.annotations.Test;

import io.restassured.RestAssured;
import io.restassured.http.Method;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import RestAssured.APITesting.POST_API.supportfilePatApp;


public class PatApp_request {
	
	@Test
	
	public void postTest() throws IOException, ParseException {
		
		supportfilePatApp other = new supportfilePatApp();
		other.postTest();
		
//        try {
//            // Step 1: Read the JSON file
//            File jsonFile = new File("./testdata/put_request/POST_reqpayload_updated.json");
//            FileReader reader = new FileReader(jsonFile);
//            ObjectMapper objectMapper = new ObjectMapper();
//            ObjectNode jsonNode = (ObjectNode) objectMapper.readTree(reader);
//            // Step 2: Generate a random value for NEWMRID
//            int newMRID = (int) (Math.random() * 100000);
//            int newMRNUMB = (int) (Math.random() * 1000000);
//            // Step 3: Update the value of NEWMRID
//            ((ObjectNode) jsonNode .path("entry").path(0).path("resource").path("identifier").path(0)).put("value", newMRID);
//            ((ObjectNode) jsonNode .path("entry").path(0).path("resource").path("identifier").path(1)).put("value", newMRNUMB);        
//            // Step 4: Convert the updated Java object back to JSON
//            String updatedJson = objectMapper.writeValueAsString(jsonNode);
//            // Step 5: Write the updated JSON to a new file
//            File updatedJsonFile = new File("./testdata/put_request/POST_reqpayload_updated.json");
//            FileWriter writer = new FileWriter(updatedJsonFile);
//            writer.write(updatedJson);
//            writer.close();
//            System.out.println("NEWMRID value changed successfully!");
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
		
        
        UUID uuid = UUID.randomUUID();
        String uuidAsString = uuid.toString();
        System.out.println("Your UUID is: " + uuidAsString);
        String TransID = uuidAsString;
		JSONParser jsonparser = new JSONParser();		
		File jsonFile = new File("./testdata/put_request/POST_reqpayload_updated.json");
        FileReader reader = new FileReader(jsonFile);
		Object obj = jsonparser.parse(reader);
		JSONObject patdatajsonobj = (JSONObject) obj;
		
		ObjectMapper objectMapper = new ObjectMapper();
		File jsonfile = new File(".\\configurations\\DB\\config.json");
		
//		try {
//		    // Read the JSON file into a JsonNode object
//		    JsonNode rootNode = objectMapper.readTree(jsonfile);
//		
//		    // Get the value of the "city" field
//		    String url2 = rootNode.get("url2").asText();
//		    System.out.println("url2: " + url2);
//		} catch (IOException e) {
//		    e.printStackTrace();
//		}
	    // Read the JSON file into a JsonNode object
	    JsonNode rootNode = objectMapper.readTree(jsonfile);
	
	    // Get the value of the "city" field
	    String url2 = rootNode.get("url2").asText();
		RestAssured.baseURI = rootNode.get("url2").asText();;
		System.out.println(patdatajsonobj);
		RequestSpecification httprequest = RestAssured.given().body(patdatajsonobj);
		httprequest.given().header("x-ms-blob-type", "BlockBlob").and().header("Content-Type", "text/plain");
		System.out.println("passScript");
		System.out.println(httprequest.log().all());
//		String address = String.format(
//				"/docspera-adls/%s.json?sp=racwl&st=2023-05-08T09:01:47Z&se=2023-08-08T17:01:47Z&spr=https&sv=2022-11-02&sr=c&sig=ibHUH+ZZGgMi9ha0FspwDFVoOKPfbfc2QbN3HwYPTB8=", 
//				TransID);
		Response response = httprequest.request(Method.PUT);
//		Response response = httprequest.request(Method.PUT, address);
//		System.out.print(address);
		System.out.print(response);
		String responsebody = response.getBody().asString();
		System.out.print("pass2");
		System.out.print(responsebody);
		System.out.println("Test passed");
	}
}
