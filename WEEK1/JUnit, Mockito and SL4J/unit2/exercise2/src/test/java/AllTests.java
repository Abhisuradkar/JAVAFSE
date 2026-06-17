import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;

@Suite
@SelectClasses({
        TestClass1.class,
        TestClass2.class
})
public class AllTests {
}