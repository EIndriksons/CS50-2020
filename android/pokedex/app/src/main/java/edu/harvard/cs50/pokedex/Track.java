package edu.harvard.cs50.pokedex;

public class Track {
    private String name;
    private String instructor;

    Track(String name, String instructor) {
        this.name = name;
        this.instructor = instructor;
    }

    public String getName() {
        return name;
    }

    public String getInstructor() {
        return instructor;
    }
}
