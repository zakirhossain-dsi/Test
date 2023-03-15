package com.cefalo;

import com.vdurmont.emoji.EmojiParser;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.entity.ContentType;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;

import java.io.*;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

public class Test{
    public static void main(String[] args) throws IOException, URISyntaxException {
        String s = "\uD83E\uDDE1⌛";
        System.out.println(StringEscapeUtils.escapeHtml(s));

        System.out.println(EmojiParser.parseToHtmlDecimal(s));
        //TestExecutor t = new TestExecutor();

        //String response = getResponseFromHtml2Ans(t.getHTML());
        //System.out.println(response);
    }

    public static String getResponseFromHtml2Ans(String html) {
        String responseBody = "";
        try (var client = HttpClients.createDefault()) {
            String url = "http://html2ans-jx-staging.mentordigital.io/";
            //String url = "http://localhost:8080/";

            HttpPost httpPost = new HttpPost(url);
            ByteArrayEntity byteArrayEntity = new ByteArrayEntity(html.getBytes());
            byteArrayEntity.setContentEncoding(StandardCharsets.UTF_8.toString());
            httpPost.setEntity(byteArrayEntity);
            httpPost.setHeader(new BasicHeader(HttpHeaders.ACCEPT_ENCODING, ContentType.APPLICATION_JSON.toString()));
            httpPost.setHeader(new BasicHeader(HttpHeaders.CONTENT_TYPE, ContentType.TEXT_PLAIN.toString()));
            ResponseHandler<String> responseHandler = serverResponse -> {
                int status = serverResponse.getStatusLine().getStatusCode();
                if (status >= 200 && status < 300) {
                    HttpEntity entity = serverResponse.getEntity();

                    Reader reader = new BufferedReader(new InputStreamReader(entity.getContent()));
                    StringBuffer sb = new StringBuffer();
                    int c = 0;

                    while((c = reader.read()) != -1){
                        sb.append((char)c);
                    }
                    return sb.toString();
                    //return entity != null ? EntityUtils.toString(entity, StandardCharsets.UTF_8) : null;
                } else {
                    throw new ClientProtocolException("Unexpected response status: " + status);
                }
            };

            responseBody = client.execute(httpPost, responseHandler);
            if (StringUtils.isNotBlank(responseBody)){
                responseBody = StringEscapeUtils.unescapeJava(responseBody);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseBody;
    }

    public String getHTML() throws URISyntaxException, IOException {
        StringBuilder body = new StringBuilder();
        File myObj = new File("test.txt");
        Scanner myReader = new Scanner(myObj);
        while (myReader.hasNextLine()) {
            body.append(myReader.nextLine());
        }
        return body.toString();
    }
}
