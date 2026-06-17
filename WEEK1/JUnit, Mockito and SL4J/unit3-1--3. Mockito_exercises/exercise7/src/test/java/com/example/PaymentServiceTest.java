import static org.junit.jupiter.api.Assertions.assertThrows;
import org.junit.jupiter.api.Test;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;

public class PaymentServiceTest {

    @Test
    void testVoidException() {

        PaymentService service =
                mock(PaymentService.class);

        doThrow(
            new RuntimeException("Payment Failed")
        ).when(service).pay();

        assertThrows(
            RuntimeException.class,
            () -> service.pay()
        );
    }
}