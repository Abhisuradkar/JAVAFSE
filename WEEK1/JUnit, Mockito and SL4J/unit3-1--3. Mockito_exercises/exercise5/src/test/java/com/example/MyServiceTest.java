import org.junit.jupiter.api.Test;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

public class MyServiceTest {

    @Test
    void testMultipleReturns() {

        ExternalApi mockApi =
                mock(ExternalApi.class);

        when(mockApi.getData())
                .thenReturn("Data1")
                .thenReturn("Data2");

        MyService service =
                new MyService(mockApi);

        assertEquals(
                "Data1",
                service.fetchData()
        );

        assertEquals(
                "Data2",
                service.fetchData()
        );
    }
}