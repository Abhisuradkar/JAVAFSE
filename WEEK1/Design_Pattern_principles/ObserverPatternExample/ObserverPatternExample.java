public class ObserverPatternExample {

    public static void main(String[] args) {

        Stock stock = new Stock();

        Observer mobile = new MobileApp();
        Observer web = new WebApp();

        stock.registerObserver(mobile);
        stock.registerObserver(web);

        stock.setPrice(100.50);
        stock.setPrice(120.75);
    }
}