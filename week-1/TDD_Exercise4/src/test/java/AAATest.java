import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class AAATest {

    private int num1;
    private int num2;
    private int result;

    @Before
    public void setUp() {
        System.out.println("Setting up test...");
        num1 = 10;
        num2 = 20;
    }

    @Test
    public void testAddition() {

        // Arrange
        // num1 and num2 are already initialized in setUp()

        // Act
        result = num1 + num2;

        // Assert
        assertEquals(30, result);
    }

    @After
    public void tearDown() {
        System.out.println("Cleaning up after test...");
    }
}