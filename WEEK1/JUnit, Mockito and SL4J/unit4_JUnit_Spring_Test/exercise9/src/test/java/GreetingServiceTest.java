import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class GreetingServiceTest {

    @Test
    void testBean() {

        ApplicationContext context =
                new AnnotationConfigApplicationContext(AppConfig.class);

        GreetingService service =
                context.getBean(GreetingService.class);

        assertEquals("Hello Spring", service.greet());
    }
}