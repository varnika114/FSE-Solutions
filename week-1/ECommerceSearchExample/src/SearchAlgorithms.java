import java.util.Arrays;
import java.util.Comparator;
import java.util.Scanner;

public class SearchAlgorithms {

    // Linear Search
    public static Product linearSearch(Product[] products, int id) {

        for (Product p : products) {
            if (p.productId == id) {
                return p;
            }
        }

        return null;
    }

    // Binary Search
    public static Product binarySearch(Product[] products, int id) {

        int low = 0;
        int high = products.length - 1;

        while (low <= high) {

            int mid = (low + high) / 2;

            if (products[mid].productId == id) {
                return products[mid];
            } else if (products[mid].productId < id) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return null;
    }

    public static void main(String[] args) {

        Product[] products = {

                new Product(103, "Laptop", "Electronics"),
                new Product(101, "Shoes", "Fashion"),
                new Product(105, "Phone", "Electronics"),
                new Product(102, "Watch", "Accessories"),
                new Product(104, "Bag", "Fashion")

        };

        Scanner sc = new Scanner(System.in);

        System.out.print("Enter Product ID to search: ");
        int id = sc.nextInt();

        // Linear Search
        System.out.println("\nLinear Search:");

        Product p1 = linearSearch(products, id);

        if (p1 != null)
            p1.display();
        else
            System.out.println("Product not found");

        // Sort array for Binary Search
        Arrays.sort(products, Comparator.comparingInt(p -> p.productId));

        // Binary Search
        System.out.println("\nBinary Search:");

        Product p2 = binarySearch(products, id);

        if (p2 != null)
            p2.display();
        else
            System.out.println("Product not found");

        sc.close();
    }
}
