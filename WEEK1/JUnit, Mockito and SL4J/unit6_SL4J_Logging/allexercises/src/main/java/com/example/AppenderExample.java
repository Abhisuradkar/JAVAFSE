import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AppenderExample {

    private static final Logger logger =
            LoggerFactory.getLogger(AppenderExample.class);

    public static void main(String[] args) {

        logger.debug("Debug Message");
        logger.info("Info Message");
        logger.warn("Warning Message");
        logger.error("Error Message");
    }
}