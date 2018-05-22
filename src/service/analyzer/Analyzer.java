package service.analyzer;

import bean.Bean;
import bean.FacebookBean;


import java.util.List;
import java.util.TreeMap;

public interface Analyzer {

    public TreeMap<String, Integer> evaluatePosts(List<Bean> posts);
}
