package RestAssured.APITesting.POST_API;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class calculator {
    public static int globalInt1;
    public static int globalInt2;

    public static void main(String[] args) {
        globalInt1 = 10;
        globalInt2 = 20;

        int sum = addTwoIntegers(globalInt1, globalInt2);
        System.out.println("Sum: " + sum);

        int product = multiplyTwoIntegers(globalInt1, globalInt2);
        System.out.println("Product: " + product);
    }

    public static int addTwoIntegers(int a, int b) {
        return a + b;
    }

    public static int multiplyTwoIntegers(int a, int b) {
        return a * b;
    }
//    public static int x;
//    public static int y;
//    
//    public static void main(String[] args) {
//    	
//       int x = 70;
//       int y = 20;
//       int sum = x + y;
//       System.out.println(sum);
////       System.out.println("sum");
//    }
//    
//    public static void add() {
//    	int sum = x + y;
//    	System.out.println("sum");
//    	System.out.println(sum);
//    }
}

