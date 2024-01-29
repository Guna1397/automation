import java.net.HttpURLConnection;
import java.net.URL;

public class ApiRequestExample {
    public static void main(String[] args) {
        String sasToken = "your_sas_token_here";
        String apiUrl = "https://api.example.com/endpoint";

        try {
            // Append the SAS token to the API URL
            String urlWithSasToken = apiUrl + "?" + sasToken;
            URL url = new URL(urlWithSasToken);

            // Open a connection to the API endpoint
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // Set the request method, e.g., GET, POST, etc.
            connection.setRequestMethod("GET");

            // Set any required request headers
            connection.setRequestProperty("Content-Type", "application/json");

            // Send the request and retrieve the response
            int responseCode = connection.getResponseCode();

            // Process the response code and data as needed
            System.out.println("Response Code: " + responseCode);

            // Close the connection
            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
