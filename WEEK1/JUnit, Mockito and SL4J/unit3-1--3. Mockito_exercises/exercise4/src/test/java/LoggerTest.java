import org.junit.jupiter.api.Test;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

public class LoggerTest {

    @Test
    void testVoidMethod() {

        Logger logger = mock(Logger.class);

        doNothing().when(logger)
                .log(anyString());

        logger.log("Hello");

        verify(logger).log("Hello");
    }
}