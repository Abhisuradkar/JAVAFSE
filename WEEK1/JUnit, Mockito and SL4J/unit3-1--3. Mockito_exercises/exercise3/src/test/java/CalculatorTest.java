import org.junit.jupiter.api.Test;

import static org.mockito.Mockito.*;

public class CalculatorTest {

    @Test
    void testArgumentMatching() {

        Calculator calc = mock(Calculator.class);

        calc.add(10, 20);

        verify(calc).add(anyInt(), anyInt());
    }
}