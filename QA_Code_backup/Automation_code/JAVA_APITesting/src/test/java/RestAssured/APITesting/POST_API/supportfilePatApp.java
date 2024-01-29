package RestAssured.APITesting.POST_API;

import java.io.FileReader;
import java.io.IOException;
import java.io.FileWriter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.io.File;
import org.json.simple.parser.ParseException;
import org.testng.annotations.Test;



public class supportfilePatApp {
	
	@Test
	
	public void postTest() throws IOException, ParseException {
		
		System.out.println("class successfully imported");
		
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
	}
}
