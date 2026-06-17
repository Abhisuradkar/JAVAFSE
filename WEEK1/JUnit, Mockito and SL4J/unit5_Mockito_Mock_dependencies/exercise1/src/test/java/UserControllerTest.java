import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;

public class UserControllerTest {

    @Mock
    private UserService userService;

    @InjectMocks
    private UserController userController;

    public UserControllerTest() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetUser() {

        User user = new User(1L, "Abhishek");

        when(userService.getUserById(1L))
                .thenReturn(user);

        User result =
                userController.getUser(1L).getBody();

        assertNotNull(result);
        assertEquals("Abhishek", result.getName());
    }
}