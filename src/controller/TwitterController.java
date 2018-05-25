package controller;

import bean.Bean;
import constants.TwitterConstants;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import service.analyzer.TwitterAnalyzer;
import service.sourcedata.TwitterSourceData;
import twitter4j.*;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;
import twitter4j.conf.ConfigurationBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

@Controller
public class TwitterController {
    @RequestMapping("/twitter")
    public ModelAndView getCodeForTwitter(HttpServletRequest req, HttpServletResponse res) {
        ModelAndView mvObj = new ModelAndView("index");
        try {
            RequestToken requestToken = (RequestToken) req.getSession().getAttribute("requestToken");
            TwitterSourceData twitterSourceDataObj = new TwitterSourceData();
            String oauthVerifier = req.getParameter("oauth_verifier");
            AccessToken accessToken = twitterSourceDataObj.generateAccessToken(requestToken, oauthVerifier);
            req.getSession().setAttribute("accessTokenForTwitter", accessToken);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return mvObj;
    }

}
