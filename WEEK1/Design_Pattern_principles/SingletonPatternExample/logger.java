public class logger {
    private static logger instance;

    private logger() {}

    public static logger getInstance() {
        if(instance == null) {
            instance = new logger();
        }
        return instance;
    }

    public void log(String msg) {
        System.out.println("LOG: " + msg);
    }
}