package controller;

import bean.Bean;
import bean.FacebookBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import service.analyzer.FacebookAnalyzer;
import service.sourcedata.FacebookSourceData;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

@Controller
public class FacebookController {
    @RequestMapping("/FriendList")
    public ModelAndView getCode(@RequestParam("code") String code, HttpServletRequest req, HttpServletResponse res) throws Exception {
        ModelAndView mvObj = new ModelAndView("index");

        FacebookSourceData facebookSourceDataObj = new FacebookSourceData();
        String accessToken = facebookSourceDataObj.generateAccessToken(code);
        req.getSession().setAttribute("accessTokenForFacebook", accessToken);
        return mvObj;

    }
}


