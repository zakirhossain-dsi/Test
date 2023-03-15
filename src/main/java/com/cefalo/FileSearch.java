package com.cefalo;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class FileSearch {

    public static void main(String[] args) throws FileNotFoundException{
        FileSearch fileSearch = new FileSearch();
        Scanner scan = new Scanner(new File("DebugExtractor.txt"));
        while(scan.hasNextLine()){
            fileSearch.parseFile("DebugTransformerEnrichment.txt", scan.nextLine());
        }
    }

    public void parseFile(String fileName, String searchStr) throws FileNotFoundException{
        boolean hasFound = false;
        Scanner scan = new Scanner(new File(fileName));
        while(scan.hasNext()){
            String line = scan.nextLine();
            if(searchStr.trim().equals(line.trim())) {
                hasFound = true;
                break;
            }
        }
        if(!hasFound){
            System.out.println(searchStr);
        }
    }
}
