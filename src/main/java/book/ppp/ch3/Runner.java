package book.ppp.ch3;

import org.apache.commons.lang.ArrayUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

public class Runner {
    public static void main(String[] args) {
        Set<String> priorities = Set.of("regular", "express");
        Set<String> sources = Set.of("polopoly", "reportasje");
        Set<String> content_types = Set.of("article", "image", "author");
        Set<String> publishers = Set.of("dagen.se", "vl.no", "dagsavisen.no", "klartale.no");

        List<String[]> uniqueTags = new ArrayList<>();

        for(String priority : priorities){
            for(String source : sources){
                for(String content_type : content_types){
                    for(String publisher : publishers){
                        uniqueTags.add(new String[]{
                                "priority", priority,
                                "source", source,
                                "content_type", content_type,
                                "publisher", publisher
                        });
                    }
                }
            }
        }
    }
}
