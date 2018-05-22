package service.analyzer;

import bean.Bean;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class TwitterAnalyzer implements Analyzer{
    @Override
    public TreeMap<String, Integer> evaluatePosts(List<Bean> posts){
        HashMap<String,Integer> map = new HashMap<>();
        for(Bean bean_obj: posts){
            String year = bean_obj.getCreatedAt().substring(24,28);
            if(map.containsKey(year)) {
                Integer count = map.get(year);
                map.put(year,count+1);
            }
            else{
                map.put(year,1);
            }

        }
        TreeMap<String,Integer> sortedMap = new TreeMap<>();
        sortedMap.putAll(map);
        for(Map.Entry<String,Integer> m : sortedMap.entrySet()){
            System.out.println(m);
        }
        return sortedMap;
    }
}
