package RestAssured.APITesting.POST_API;


//
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.fasterxml.jackson.databind.node.ObjectNode;
//import java.io.File;
//import java.io.FileReader;
//import java.io.FileWriter;
//import java.io.IOException;
//import java.util.UUID;
//
//public class test {
//    public static void main(String[] args) {
//        try {
//            // Step 1: Read the JSON file
//            File jsonFile = new File("./testdata/put_request/POST_reqpayload.json");
//            FileReader reader = new FileReader(jsonFile);
//            ObjectMapper objectMapper = new ObjectMapper();
//            ObjectNode jsonNode = (ObjectNode) objectMapper.readTree(reader);
//            System.out.println(jsonNode);
//            // Step 2: Generate a random value for NEWMRID
//            String newMRID = UUID.randomUUID().toString();
//            System.out.println(newMRID);
//            
//            // Step 3: Update the value of NEWMRID
//            ((ObjectNode) jsonNode
//                .path("entry")
//                .path(0)
//                .path("resource")
//                .path("identifier")
//                .path(0))
//                .put("value", newMRID);
//
//            // Step 4: Convert the updated Java object back to JSON
//            String updatedJson = objectMapper.writeValueAsString(jsonNode);
//
//            // Step 5: Write the updated JSON to a new file
//            File updatedJsonFile = new File("./testdata/put_request/POST_reqpayload_updated.json");
//            FileWriter writer = new FileWriter(updatedJsonFile);
//            writer.write(updatedJson);
//            writer.close();
//
//            System.out.println("NEWMRID value changed successfully!");
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
//}



import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class test {
    public static void main(String[] args) {
//        ObjectMapper objectMapper = new ObjectMapper();
//        try {
//            // Parse the JSON file
//            File jsonFile = new File("./testdata/put_request/POST_reqpayload.json");
//            ObjectNode jsonObject = (ObjectNode) objectMapper.readTree(jsonFile);
//
//            // Generate random values for NEWMRID and MRNUMB
//            String newMRID = UUID.randomUUID().toString();
//            String newMRNUMB = "MR-" + UUID.randomUUID().toString();
//
//            // Update the values in the JSON object
//            ((ObjectNode) jsonObject.get("entry").get(0).get("resource").get("identifier").get(0)).put("value", newMRID);
//            ((ObjectNode) jsonObject.get("entry").get(0).get("resource").get("identifier").get(1)).put("value", newMRNUMB);
//
//            // Convert the updated JSON object back to a string
//            String updatedJsonString = objectMapper.writeValueAsString(jsonObject);
//
//            // Print the updated JSON string
//            System.out.println(updatedJsonString);
//
//            // Write the updated JSON string back to the file if needed
//            // objectMapper.writeValue(jsonFile, jsonObject);
//        } catch (IOException e) {
//            e.printStackTrace();
    	
		ObjectMapper objectMapper = new ObjectMapper();
		File jsonFile = new File(".\\configurations\\DB\\config.json");
		
		try {
		    // Read the JSON file into a JsonNode object
		    JsonNode rootNode = objectMapper.readTree(jsonFile);
		
		    // Get the value of the "city" field
		    String url = rootNode.get("url2").asText();
		    System.out.println("url2: " + url);
		} catch (IOException e) {
		    e.printStackTrace();
		}
       
    }
}

