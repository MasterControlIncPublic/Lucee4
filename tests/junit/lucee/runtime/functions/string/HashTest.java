package lucee.runtime.functions.string;

import lucee.runtime.crypt.FipsAlgorithm;
import org.bouncycastle.jcajce.provider.BouncyCastleFipsProvider;
import org.junit.jupiter.api.Test;

import java.security.Security;

import static org.junit.jupiter.api.Assertions.assertEquals;

class HashTest {

    @Test
    void shouldHashUUIDWithDefaultAlgorithmAndIterations() throws Exception {
        Security.addProvider(new BouncyCastleFipsProvider());
        String result = Hash.invoke(null, "41cb5016-239d-4abd-979f-8f212a8f8a89", null, 0);
        assertEquals("CF4009C82B61F0E0266CA40596B1000C7E31574D9E24D46E1D52B0445A2669DA", result);
    }

    @Test
    void shouldHashUUIDWithDefaultIterations() throws Exception {
        Security.addProvider(new BouncyCastleFipsProvider());
        String result = Hash.invoke(null, "41cb5016-239d-4abd-979f-8f212a8f8a89", FipsAlgorithm.SHA256, 0);
        assertEquals("CF4009C82B61F0E0266CA40596B1000C7E31574D9E24D46E1D52B0445A2669DA", result);
    }

    @Test
    void shouldHashUUID() throws Exception {
        Security.addProvider(new BouncyCastleFipsProvider());
        String result = Hash.invoke(null, "41cb5016-239d-4abd-979f-8f212a8f8a89", FipsAlgorithm.SHA256, 1000);
        assertEquals("39FC061B357D9AD1A999B5240067CB63D0CEAF559B3E5832339CE143277DA521", result);
    }
}