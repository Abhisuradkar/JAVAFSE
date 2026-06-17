public class Main {
    public static void main(String[] args) {
        logger l1 = logger.getInstance();
        logger l2 = logger.getInstance();

        l1.log("Application Started");

        System.out.println(l1 == l2);
    }
}