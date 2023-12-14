package lucee.commons.io;

import lucee.cli.servlet.ServletContextImpl;
import org.junit.jupiter.api.Test;

import javax.servlet.ServletContext;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class SystemUtilTest {

    @Test
    void hashShouldReturnMd5Algorithm() {
        ServletContext context = mock(ServletContextImpl.class);
        when(context.getRealPath(anyString())).thenReturn("/my/real/path");
        assertEquals("191291a88c51768e78ddd5b0cd9c23b0", SystemUtil.hash(context));
    }
}