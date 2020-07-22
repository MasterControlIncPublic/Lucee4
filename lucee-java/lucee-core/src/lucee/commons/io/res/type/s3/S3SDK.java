package lucee.commons.io.res.type.s3;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ListObjectsV2Request;
import com.amazonaws.services.s3.model.ListObjectsV2Result;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.mastercontrol.resource.S3ClientManager;
import lucee.commons.io.StreamWithSize;
import org.apache.commons.collections.map.ReferenceMap;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class S3SDK {
    private String accessKey;
    private String secretKey;
    private AmazonS3 client;

    private static final Map<String,S3Info> infos= new ReferenceMap();

    public S3SDK() {
        this("","");
        System.out.println("Empty Constructor");
    }

    public S3SDK(String accessKey, String secretKey) {
        this.accessKey = accessKey;
        this.secretKey = secretKey;
    }

    // todo maybe goes away?
    void setSecretKey(String secretKey) {
        this.secretKey = secretKey;
    }

    // todo maybe goes away?
    void setAccessKey(String accessKey) {
        this.accessKey = accessKey;
    }

    private AmazonS3 getClient() {
        return S3ClientManager.getClient();
    }

    public void releaseCache(String path) {
        Object k = toKey(path);
        infos.remove(k);
    }

    public Content[] listContents(String bucketName,String prefix) {
        String continuationToken = null;
        List<Content> contents = new ArrayList<>();

        do {
            ListObjectsV2Request listObjectsRequest = new ListObjectsV2Request().withBucketName(bucketName)
                                                                                    .withDelimiter("/");

            if (prefix != null) {
                listObjectsRequest.setPrefix(prefix);
            }
            if (continuationToken != null) {
                listObjectsRequest.setContinuationToken(continuationToken);
            }

            ListObjectsV2Result listing = getClient().listObjectsV2(listObjectsRequest);

            contents.addAll(listing.getObjectSummaries().stream()
                   .map(summary -> Content.fromObjectSummary(this, summary))
                   .collect(Collectors.toList()));
            contents.addAll(listing.getCommonPrefixes().stream()
                                   .map(folderName -> Content.forFolder(this, bucketName, folderName))
                                   .collect(Collectors.toList()));
            continuationToken = listing.getNextContinuationToken();
        } while (continuationToken != null);
        return contents.toArray(new Content[]{});
    }

    public void put(String bucketName, String objectName, StreamWithSize stream) throws IOException {
        // todo multi-part upload?
        InputStream input = stream.getInputStream();

        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(stream.getSize());
        PutObjectRequest pub = new PutObjectRequest(bucketName, objectName, input, metadata);
        getClient().putObject(pub);
    }

    public InputStream getInputStream(String bucketName,String objectName) {
        return getClient().getObject(bucketName, objectName).getObjectContent();
    }

    public void delete(String bucketName, String objectName) {
        getClient().deleteObject(bucketName, objectName);
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
