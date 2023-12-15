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
        String result = Hash.invoke(null, "41cb5016-239d-4abd-979f-8f212a8f8a89", null, 1);
//        assertEquals("18F7459130E82CDB8A2247868820AF885851279EBCCBCFC2E88FD3B7C72F3EC3", result);
    }

    @Test
    void shouldHashUUIDWithDefaultIterations() throws Exception {
        Security.addProvider(new BouncyCastleFipsProvider());
        String result = Hash.invoke(null, "41cb5016-239d-4abd-979f-8f212a8f8a89", FipsAlgorithm.SHA256, 1);
//        assertEquals("18F7459130E82CDB8A2247868820AF885851279EBCCBCFC2E88FD3B7C72F3EC3", result);
    }

    @Test
    void shouldHashUUID() throws Exception {
        Security.addProvider(new BouncyCastleFipsProvider());
        String result = Hash.invoke(null, "41cb5016-239d-4abd-979f-8f212a8f8a89", FipsAlgorithm.SHA256, 1000000);
//        assertEquals("E7A42F91B2E4E51BF9F2C4137939E9175D9E1F9023EE7CBE3CEC815CD43A6FEA", result);
    }
}