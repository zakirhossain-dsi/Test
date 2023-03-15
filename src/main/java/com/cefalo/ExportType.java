package com.cefalo;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

public enum ExportType {

    ARTICLE("Article"),
    LONGREADARTICLE("LongReadArticle"),
    AUTHOR("Author"),
    IMAGE("Image"),
    PAGE("Page"),
    CATEGORY("Category"),
    IMAGEGALLERY("ImageGallery"),
    QUOTE("Quote"),
    LINK("Link"),
    POLL("Poll"),
    CUSTOM_ELEMENTS("CustomElements"),
    SITES("Sites");

    private final String displayName;
    private static Map<String, ExportType> displayNamesMap;

    ExportType(String displayName) {
        this.displayName = displayName;
        getDisplayNamesMap().put(displayName.toLowerCase(), this);
    }

    private static Map<String, ExportType> getDisplayNamesMap() {
        if (Objects.isNull(displayNamesMap)) {
            displayNamesMap = new HashMap<>();
        }
        return displayNamesMap;
    }

    public String getDisplayName() {
        return displayName;
    }

    public static ExportType of(String exportType) {
        return getDisplayNamesMap().get(exportType.trim().toLowerCase());
    }

    public static Optional<ExportType> getByName(String name){
        return displayNamesMap.values().stream().filter(e -> e.name().equals(name)).findFirst();
    }
}

