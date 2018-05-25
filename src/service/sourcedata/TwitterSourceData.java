package service.sourcedata;

import bean.Bean;
import bean.FacebookBean;
import constants.TwitterConstants;
import twitter4j.*;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;
import twitter4j.conf.ConfigurationBuilder;

import java.util.ArrayList;
import java.util.List;


public class TwitterSourceData implements SourceData {
    @Override
    public List<Bean> getPosts(String accessToken, String tokenSecret) {
        List<Status> status = null;
        Twitter twitter = new TwitterFactory().getInstance();
        twitter.setOAuthConsumer(TwitterConstants.OAUTH_CONSUMER_KEY, TwitterConstants.OAUTH_CONSUMER_SECRET);
        // twitter.verifyCredentials();
        ConfigurationBuilder cf = new ConfigurationBuilder();
        cf.setDebugEnabled(true)
                .setOAuthConsumerKey(TwitterConstants.OAUTH_CONSUMER_KEY)
                .setOAuthConsumerSecret(TwitterConstants.OAUTH_CONSUMER_SECRET)
                .setOAuthAccessToken(accessToken)
                .setOAuthAccessTokenSecret(tokenSecret);
        TwitterFactory tf = new TwitterFactory(cf.build());
        twitter = tf.getInstance();
        try {
            status = twitter.getUserTimeline();
        } catch (TwitterException e) {
            e.printStackTrace();
        }
        List<Bean> twitterList = new ArrayList<Bean>();
        for (Status statusObj : status) {
            Bean twitterBeanObj = new Bean();
            twitterBeanObj.setCreatedAt(statusObj.getCreatedAt().toString());
            twitterBeanObj.setId(String.valueOf(statusObj.getId()));
            twitterBeanObj.setText(statusObj.getText());
            twitterList.add(twitterBeanObj);

        }
        return twitterList;
    }
    public AccessToken generateAccessToken(RequestToken requestToken, String oauthVerifier) {
        AccessToken accessToken= null;
        try {
            Twitter twitter=new TwitterFactory().getInstance();
            twitter.setOAuthConsumer(TwitterConstants.OAUTH_CONSUMER_KEY,TwitterConstants.OAUTH_CONSUMER_SECRET);

            accessToken = twitter.getOAuthAccessToken(requestToken,oauthVerifier);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accessToken;
    }
    public boolean post(AccessToken accessToken, String message)
    {
        boolean flag=false;
        try {
            ConfigurationBuilder cf = new ConfigurationBuilder();
            cf.setDebugEnabled(true)
                    .setOAuthConsumerKey(TwitterConstants.OAUTH_CONSUMER_KEY)
                    .setOAuthConsumerSecret(TwitterConstants.OAUTH_CONSUMER_SECRET)
                    .setOAuthAccessToken(accessToken.getToken())
                    .setOAuthAccessTokenSecret(accessToken.getTokenSecret());
            TwitterFactory tf = new TwitterFactory(cf.build());
            Twitter twitter = tf.getInstance();
            twitter.updateStatus(message);
            flag=true;
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return flag;

    }

}