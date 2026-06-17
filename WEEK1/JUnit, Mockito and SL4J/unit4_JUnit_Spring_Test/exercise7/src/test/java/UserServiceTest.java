import static org.junit.jupiter.api.Assertions.assertThrows;
import org.junit.jupiter.api.Test;

public class UserServiceTest {

    @Test
    void testException() {
        UserService service = new UserService();

        assertThrows(
                IllegalArgumentException.class,
                () -> service.getUser(-1)
        );
    }
}