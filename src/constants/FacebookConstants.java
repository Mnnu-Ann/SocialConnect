package constants;

import java.net.URLEncoder;

public final class FacebookConstants {
    public static final String CLIENT_ID = "899703630198828";
    public static final String CLIENT_SECRET = "f24ec98c855df587980c2d85cb9b912e";
    public static final String REDIRECT_URI = "http://localhost:8080/FriendList";
    public static final String SCOPE ="email,user_friends,user_posts,publish_actions";

    public static final String FACEBOOK_TOKEN_URL = "https://graph.facebook.com/oauth/access_token?grant_type=authorization_code&client_id="+CLIENT_ID+"&client_secret="+CLIENT_SECRET+"&redirect_uri="+REDIRECT_URI+"&scope="+SCOPE+"&code=";
    public static final String ACCESS_TOKEN_URL = "https://graph.facebook.com/v2.12/me/posts?access_token=";
    public static final String ENCODED_REDIRECT_URI = URLEncoder.encode(REDIRECT_URI);
    public static final String AUTH_URL = "'https://graph.facebook.com/oauth/authorize?response_type=code&client_id="+CLIENT_ID+"&redirect_uri="+ENCODED_REDIRECT_URI+"&scope="+SCOPE;
}
