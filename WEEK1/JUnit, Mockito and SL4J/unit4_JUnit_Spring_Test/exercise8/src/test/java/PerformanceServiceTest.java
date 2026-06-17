import java.time.Duration;

import static org.junit.jupiter.api.Assertions.assertTimeout;
import org.junit.jupiter.api.Test;

public class PerformanceServiceTest {

    @Test
    void testTimeout() {

        PerformanceService service = new PerformanceService();

        assertTimeout(Duration.ofSeconds(2), () -> {
            service.process();
        });
    }
}