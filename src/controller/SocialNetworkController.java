package controller;


import bean.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import service.analyzer.FacebookAnalyzer;
import service.analyzer.TwitterAnalyzer;
import service.sourcedata.FacebookSourceData;
import service.sourcedata.TwitterSourceData;
import twitter4j.TwitterException;
import twitter4j.auth.AccessToken;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
public class SocialNetworkController {


    @RequestMapping("/shareOnSocialMedia")
    public ModelAndView postOnSocialMedia(@RequestParam("message") String message, HttpServletRequest req , HttpServletResponse res)
    {
        ModelAndView mvObj = new ModelAndView("index");
        try {
            AccessToken accessTokenForTwitter= (AccessToken) req.getSession().getAttribute("accessTokenForTwitter");
            if(accessTokenForTwitter != null) {
                TwitterSourceData twitterSourceDataObj = new TwitterSourceData();
                Boolean flag = twitterSourceDataObj.post(accessTokenForTwitter, message);
            }

            String accessTokenForFacebook = (String) req.getSession().getAttribute("accessTokenForFacebook");
            if(accessTokenForFacebook != null) {
                FacebookSourceData facebookSourceDataObj = new FacebookSourceData();
                Boolean flag = facebookSourceDataObj.post(accessTokenForFacebook, message);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return mvObj;
    }

    @RequestMapping("/result")
    public ModelAndView viewAnalysis(HttpServletRequest req , HttpServletResponse res) throws TwitterException {

        ModelAndView mvObj = new ModelAndView("index");
        Set years = new TreeSet();
        req.getSession().setAttribute("viewAnalysisClicked", true);
        AccessToken accessTokenForTwitter= (AccessToken) req.getSession().getAttribute("accessTokenForTwitter");
        if(accessTokenForTwitter != null) {
            TwitterSourceData twitterSourceDataObj = new TwitterSourceData();
            List<Bean> twitterPostsList = twitterSourceDataObj.getPosts(accessTokenForTwitter.getToken(), accessTokenForTwitter.getTokenSecret());
            TwitterAnalyzer twitterAnalyzerObj = new TwitterAnalyzer();
            TreeMap<String, Integer> twitterMap = twitterAnalyzerObj.evaluatePosts(twitterPostsList);
            List<String> twYearList = new ArrayList<>();
            List<Integer> twPostList = new ArrayList<>();
            for (Map.Entry<String, Integer> m : twitterMap.entrySet()) {
                twYearList.add(m.getKey());
                twPostList.add(m.getValue());
            }
            years.addAll(twYearList);
            mvObj.addObject("twMap",twitterMap);
            mvObj.addObject("TwitteryearList",twYearList);
            mvObj.addObject("TwitterpostsList",twPostList);
        }
        String accessTokenForFacebook= (String) req.getSession().getAttribute("accessTokenForFacebook");
        if(accessTokenForFacebook != null) {
            FacebookSourceData facebookSourceDataObj = new FacebookSourceData();
            List<Bean> facebookPosts = facebookSourceDataObj.getPosts(accessTokenForFacebook, "");
            FacebookAnalyzer facebookAnalyzerObj = new FacebookAnalyzer();
            TreeMap<String, Integer> facebookMap = facebookAnalyzerObj.evaluatePosts(facebookPosts);
            List<String> fbYearList = new ArrayList<>();
            List<Integer> fbPostList = new ArrayList<>();
            for (Map.Entry<String, Integer> m : facebookMap.entrySet()) {
                fbYearList.add(m.getKey());
                fbPostList.add(m.getValue());
            }
            System.out.println(fbYearList);
            System.out.println(fbPostList);
            years.addAll(fbYearList);

            mvObj.addObject("fbMap", facebookMap);
            mvObj.addObject("yearList", fbYearList);
            mvObj.addObject("postsList", fbPostList);
        }
        mvObj.addObject("years", years);
        return mvObj;
    }

}