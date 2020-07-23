package lucee.commons.io.res.type.s3;

import com.mastercontrol.resource.s3.S3Facade;
import lucee.commons.io.StreamWithSize;
import org.apache.commons.collections.map.ReferenceMap;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

public class S3SDK {

    private static final Map<String,S3Info> infos= new ReferenceMap();

    public S3SDK() {
    }

    public void releaseCache(String path) {
        Object k = toKey(path);
        infos.remove(k);
    }

    public Content[] listContents(String bucketName,String prefix) {
        return new S3Facade(bucketName, prefix)
                .listContents()
                .stream()
                .map(Content::fromS3ListItem)
                .toArray(Content[]::new);
    }

    public void put(String bucketName, String objectName, StreamWithSize stream) throws IOException {
        new S3Facade(bucketName, objectName).putInputStream(stream.getInputStream(), stream.getSize());
    }

    public InputStream getInputStream(String bucketName,String objectName) {
        return new S3Facade(bucketName, objectName).getInputStream();
    }

    public void delete(String bucketName, String objectName) {
        new S3Facade(bucketName, objectName).delete();
    }

    public S3Info getInfo(String path) {
        return infos.get(toKey(path));
    }

    public void setInfo(String path,S3Info info) {
        infos.put(toKey(path),info);
    }

    private String toKey(String path) {
        return toString()+":"+path.toLowerCase();
    }
}
