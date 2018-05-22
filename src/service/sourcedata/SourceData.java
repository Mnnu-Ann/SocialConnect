package service.sourcedata;

import bean.Bean;
import bean.FacebookBean;
import twitter4j.TwitterException;

import java.util.List;

public interface SourceData {
    public List<Bean> getPosts(String accessToken,String tokenSecret) throws TwitterException;


}
