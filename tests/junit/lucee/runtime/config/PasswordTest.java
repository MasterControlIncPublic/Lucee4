package lucee.runtime.config;

import org.dom4j.dom.DOMElement;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.platform.commons.util.StringUtils;
import org.mockito.Spy;
import org.w3c.dom.Element;

import static org.junit.jupiter.api.Assertions.*;

class PasswordTest {

    @Test
    void shouldEncryptDecryptElementPassword() {
        Password password = Password.getInstanceFromRawPassword("password", "salt");
        Element element = new DOMElement("name");
        element.setAttribute("default-password", "");
        Password.store(element, password, true);
        element.removeAttribute("default-hspw");

        password = Password.getInstance(element, "salt", true);

        assertNotNull(password);
        assertTrue(StringUtils.isNotBlank(element.getAttribute("default-password")));
        assertEquals("e5776408ce174602142a12474456fef89b87c40d581fa267b1df7cea6c61d1c7", password.password);
        assertEquals("password", password.rawPassword);
    }
}