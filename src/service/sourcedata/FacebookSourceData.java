package service.sourcedata;

import bean.Bean;
import bean.FacebookBean;
import com.restfb.DefaultFacebookClient;
import com.restfb.Facebook;
import com.restfb.FacebookClient;
import com.restfb.Parameter;
import com.restfb.types.FacebookType;
import constants.FacebookConstants;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.net.ssl.HttpsURLConnection;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class FacebookSourceData implements SourceData {

    @Override
    public List<Bean> getPosts(String accessToken, String tokenSecret) {

        List<Bean> listOfPosts = new ArrayList<Bean>();
        //String url = "https://graph.facebook.com/v2.12/me/posts?access_token=" + accessToken;
        String accessTokenUrl = FacebookConstants.ACCESS_TOKEN_URL + accessToken;
        while (accessTokenUrl != null) {
            try {
                StringBuffer response = fetchPost(accessTokenUrl);

                JSONObject dataResponse = new JSONObject(response.toString());
                JSONArray dataArray = dataResponse.getJSONArray("data");
                //System.out.println(dataArray.length());
                for (int index = 0; index < dataArray.length(); index++) {
                    Bean fbBeanObj = new Bean();
                    fbBeanObj.setId(dataArray.getJSONObject(index).getString("id"));
                    fbBeanObj.setCreatedAt(dataArray.getJSONObject(index).getString("created_time"));
                    if (dataArray.getJSONObject(index).has("message"))
                        fbBeanObj.setText(dataArray.getJSONObject(index).getString("message"));
                    if (dataArray.getJSONObject(index).has("story"))
                        fbBeanObj.setText(dataArray.getJSONObject(index).getString("story"));
                    listOfPosts.add(fbBeanObj);
                }
                int size = listOfPosts.size();
                System.out.println("Size of " + size);
                if (dataArray.length() != 0) {
                    JSONObject dataPaging = new JSONObject(dataResponse.getJSONObject("paging").toString());
                    accessTokenUrl = dataPaging.getString("next");
                    //System.out.println(accessTokenUrl);
                } else
                    accessTokenUrl = null;

            } catch (Exception e) {
                System.out.println(e);
            }
        }
        System.out.println(listOfPosts.size());
        return listOfPosts;
    }

    public String generateAccessToken(String authCode) {
        //String facebookTokenUrl = "https://graph.facebook.com/oauth/access_token?grant_type=authorization_code&client_id=199572747461505&client_secret=a8e00fc950c4681f666b0d4ddc9b3a82&code=" + authCode + "&redirect_uri=http://localhost:8080/demo&scope=email,user_friends,user_posts";
        String facebookTokenUrl = FacebookConstants.FACEBOOK_TOKEN_URL + authCode;

        String accessToken = null;
        try {
            URL url = new URL(facebookTokenUrl);
            HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
            con.setRequestMethod("POST");

            int responseCode = con.getResponseCode();
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer responseStr = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                responseStr.append(inputLine);
            }
            in.close();

            //print result
            System.out.println(responseStr.toString());

            JSONObject jsonObj = new JSONObject(responseStr.toString());
            accessToken = jsonObj.getString("access_token");
            System.out.println(accessToken);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return accessToken;
    }

    public StringBuffer fetchPost(String accessTokenUrl) throws Exception {

        URL urlObj = new URL(accessTokenUrl);

        HttpURLConnection con = (HttpURLConnection) urlObj.openConnection();
        // optional default is GET
        con.setRequestMethod("GET");
        //add request header
        con.setRequestProperty("User-Agent", "Mozilla/5.0");
        int responseCode = con.getResponseCode();
        //System.out.println("\nSending 'GET' request to URL : " + accessTokenUrl);
        System.out.println("Response Code : " + responseCode);
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();
        //System.out.println(response);
        return response;

    }

    public boolean post(String accessToken, String message) {
        boolean flag = false;
        try {
            FacebookClient fbClient = new DefaultFacebookClient(accessToken);
            fbClient.publish("me/feed", FacebookType.class, Parameter.with("message", message));
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;

    }

}





