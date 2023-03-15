package com.cefalo;

import com.google.gson.Gson;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.entity.ContentType;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

public class Runner {
    public static void main(String[] args) throws IOException {

        String json = getJson();

        RevisionResponse[]  revisions = new Gson().fromJson(json, RevisionResponse[].class);
        System.out.println(revisions[0]);
        /*
        Gson gson = new Gson();
        Type listOfStoryObject = new TypeToken<ArrayList<Story>>() {}.getType();
        List<Story> stories = gson.fromJson(bodyHtmlInAnsFormat, listOfStoryObject);
        System.out.println(stories.get(0).getSubtitle());
        */

    }
    public static String getJson() throws IOException {
        StringBuilder body = new StringBuilder();
        File myObj = new File("test.txt");
        Scanner myReader = new Scanner(myObj);
        while (myReader.hasNextLine()) {
            body.append(myReader.nextLine());
        }
        return body.toString();
    }

    public static String getJsonFromServer() {
        String responseBody = "";
        var client = HttpClients.createDefault();
        try (client) {
            StringBuilder apiBuilder = new StringBuilder("https://api.sandbox.mentormedier.arcpublishing.com/content/v4/search?");
            apiBuilder.append("website=mentormedier");
            apiBuilder.append("&q=type:story");
            apiBuilder.append("&_sourceInclude=_id,created_date,headlines.basic");

            HttpGet httpGet = new HttpGet(apiBuilder.toString());
            httpGet.setHeader(new BasicHeader(HttpHeaders.AUTHORIZATION, "Bearer 55UE6HG56HDKANBMECF6OPUV3UKQOEJ65kYmUYtRHEakcONT3T2ThLJUV72+2r/3/IHj8BWI"));
            httpGet.setHeader(new BasicHeader(HttpHeaders.CONTENT_TYPE, ContentType.APPLICATION_JSON.toString()));

            ResponseHandler<String> responseHandler = serverResponse -> {
                int status = serverResponse.getStatusLine().getStatusCode();
                if (status >= 200 && status < 300) {
                    HttpEntity entity = serverResponse.getEntity();
                    return entity != null ? EntityUtils.toString(entity, StandardCharsets.UTF_8) : null;
                } else {
                    throw new ClientProtocolException("Unexpected response status: " + status);
                }
            };

            responseBody = client.execute(httpGet, responseHandler);
            //if (StringUtils.isNotBlank(responseBody)) responseBody = StringEscapeUtils.unescapeJava(responseBody);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseBody;
    }
}

