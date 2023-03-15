package com.mentormedier.etl;

import com.google.gson.Gson;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

public class Runner {
    public static void main(String[] args) throws IOException {
        Referent referent = new Referent();
        referent.setId("/bibelordet");
        referent.setProvider("api.sandbox.mentormedier.arcpublishing.com/site/v3/website");
        referent.setType("section");
        referent.setWebsite("dagen");

        WebsiteSection websiteSection = new WebsiteSection();
        websiteSection.setReferent(referent);
        websiteSection.setType("reference");

        Website website = new Website(websiteSection);

        Article article = new Article();
        article.getWebsites().put("dagen", website);
        String articleJson = new Gson().toJson(article);
        System.out.println(articleJson);

        Article article1 =  new Gson().fromJson(getJson(), Article.class);
        System.out.println(article1.getWebsites());

    }

    public static String getJson() throws IOException {
        StringBuilder body = new StringBuilder();
        File myObj = new File("article.txt");
        Scanner myReader = new Scanner(myObj);
        while (myReader.hasNextLine()) {
            body.append(myReader.nextLine());
        }
        return body.toString();
    }
}
