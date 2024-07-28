package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

import java.util.Locale;

public class DataGenerator {

    private static final Faker faker  = new Faker();



    public static String getRandomEmail() {
        return faker.name().firstName().toLowerCase(Locale.ROOT)
                + faker.random().nextInt(0, 100) + "@test.com";
    }

    public static String getRandomUserName(){
        return  faker.name().username();
    }

    public static JSONObject getRandomArticleValues(){
        JSONObject json = new JSONObject();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        json.put("title",title);
        json.put("description",description);
        json.put("body",body);

        return json;
    }


}
