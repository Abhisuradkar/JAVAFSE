import java.util.HashMap;

public class InventoryManagement {
    static HashMap<Integer, Product> inventory = new HashMap<>();

    static void addProduct(Product p) {
        inventory.put(p.productId, p);
    }

    static void updateProduct(int id, int qty) {
        if (inventory.containsKey(id)) {
            inventory.get(id).quantity = qty;
        }
    }

    static void deleteProduct(int id) {
        inventory.remove(id);
    }

    public static void main(String[] args) {
        addProduct(new Product(1, "Laptop", 10, 50000));
        addProduct(new Product(2, "Mouse", 20, 500));

        updateProduct(1, 15);
        deleteProduct(2);

        inventory.values().forEach(System.out::println);
    }
}