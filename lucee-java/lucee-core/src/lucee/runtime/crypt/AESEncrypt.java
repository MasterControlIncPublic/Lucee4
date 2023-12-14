package lucee.runtime.crypt;

import lucee.runtime.exp.PageException;
import lucee.runtime.functions.other.Decrypt;
import lucee.runtime.functions.other.Encrypt;
import org.bouncycastle.util.encoders.Hex;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

public final class AESEncrypt {

    private static String DEFAULT_SALT = "2e16a79e-e346-434c-8207-175802b03ef8";
    private static String DEFAULT_KEY = new String(
            Base64.getEncoder().encode("Ct777ZT7qRhijVEynK3evM2V".getBytes(StandardCharsets.UTF_8)),
            StandardCharsets.UTF_8);

    private AESEncrypt() { }

    public static String encrypt(String password) {
        return encrypt(password, DEFAULT_SALT, DEFAULT_KEY);
    }

    public static String encrypt(String password, String salt, String key) {
        byte[] encrypted;
        try {
            encrypted = Encrypt.invoke(password.getBytes(StandardCharsets.UTF_8),
                    key, FipsAlgorithm.AES, salt.getBytes(StandardCharsets.UTF_8), 100000);
        } catch (PageException e) {
            throw new RuntimeException(e);
        }
        return Hex.toHexString(encrypted);
    }

    public static String decrypt(String ecryptedPassword) {
        return decrypt(ecryptedPassword, DEFAULT_SALT, DEFAULT_KEY);
    }

    public static String decrypt(String ecryptedPassword, String salt, String key) {
        byte[] decrypted;
        try {
            decrypted = Decrypt.invoke(Hex.decode(ecryptedPassword),
                    key, FipsAlgorithm.AES, salt.getBytes(StandardCharsets.UTF_8), 100000);
        } catch (PageException e) {
            return null;
        }
        return new String(decrypted, StandardCharsets.UTF_8);
    }
}
