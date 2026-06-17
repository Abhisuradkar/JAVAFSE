import org.junit.jupiter.api.Test;
import org.mockito.InOrder;

import static org.mockito.Mockito.*;

public class OrderTest {

    @Test
    void testInteractionOrder() {

        ExternalApi mockApi =
                mock(ExternalApi.class);

        mockApi.getData();
        mockApi.getData();

        InOrder order =
                inOrder(mockApi);

        order.verify(mockApi).getData();
        order.verify(mockApi).getData();
    }
}