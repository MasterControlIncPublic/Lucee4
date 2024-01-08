package lucee.commons.io;

import lucee.cli.servlet.ServletContextImpl;
import org.bouncycastle.jcajce.provider.BouncyCastleFipsProvider;
import org.junit.jupiter.api.Test;

import javax.servlet.ServletContext;

import java.security.Security;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class SystemUtilTest {

    @Test
    void hashShouldReturnSha256Algorithm() {
        Security.addProvider(new BouncyCastleFipsProvider());
        ServletContext context = mock(ServletContextImpl.class);
        when(context.getRealPath(anyString())).thenReturn("/my/real/path");
        assertEquals("9fbaf4da8b7cf1cf8e35820d6cd4f92a801b9dc6f6a07080c4856c72995121e9", SystemUtil.hash(context));
    }
}