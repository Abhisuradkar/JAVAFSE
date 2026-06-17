import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class UserServiceExceptionTest {

    @Test
    void testMissingUser() {

        UserService service =
                new UserService();

        assertNull(
                service.getUserById(100L)
        );
    }
}