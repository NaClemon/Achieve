package com.example.tfliteprac;

public class Music {
    private long id;
    private String title;
    private String dataPath;

    public Music() {

    }

    public Music(long id, String title, String dataPath) {
        this.id = id;
        this.title = title;
        this.dataPath = dataPath;
    }

    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getDataPath() {
        return dataPath;
    }
    public void setDataPath(String dataPath) {
        this.dataPath = dataPath;
    }
}
