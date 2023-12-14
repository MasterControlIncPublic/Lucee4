package lucee.runtime.functions.displayFormatting;

import org.bouncycastle.jcajce.provider.BouncyCastleFipsProvider;
import org.junit.jupiter.api.Test;

import java.security.Security;

import static org.junit.jupiter.api.Assertions.*;

class HMACTest {

    @Test
    void shouldReturnHashedHexString() throws Exception {
        Security.addProvider(new BouncyCastleFipsProvider());
        String result = HMAC.call(null, "test", "key", null, "utf-8");
        assertEquals("02AFB56304902C656FCB737CDD03DE6205BB6D401DA2812EFD9B2D36A08AF159", result);
    }
}