package com.jingmax.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.jingmax.entity.ConditionInfo;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
/**
 * 解析json
 * 
 * @author zhengpeng  2020-8-28上午09:21:54
 */
public class JsonUtil {

	private JsonUtil() {

	}
	
	public static List<ConditionInfo> stringToJson(String conditionInfo){
		JSONArray conditionJson = JSON.parseArray(conditionInfo);
		Iterator<Object> conditionIterator = conditionJson.iterator();
		List<ConditionInfo> conditionInfoList = new ArrayList<>();
		ConditionInfo conditionId = new ConditionInfo();
		conditionId.setCode("ID");
		conditionId.setName("ID");
		conditionId.setType(1);
		conditionId.setWeb(0);
		conditionId.setRequired(0);
		conditionId.setSearch(0);
		conditionId.setSort(0);
		conditionId.setEntityCode("id");
		conditionInfoList.add(conditionId);
		while (conditionIterator.hasNext()) {
			JSONObject jsonObject = (JSONObject) conditionIterator.next();
			String humpStr = StringUtil.toHumpStr(jsonObject.get("code").toString(), "_", true);
			ConditionInfo condition = new ConditionInfo();
			condition.setCode(jsonObject.get("code").toString());
			condition.setName(jsonObject.get("name").toString());
			condition.setType(Integer.parseInt(jsonObject.get("type").toString()));
			String web = jsonObject.get("web").toString();
			if(web == null){
				web = "0";
			}
			condition.setWeb(Integer.parseInt(web));
			String required = jsonObject.get("required").toString();
			if(required == null){
				required = "0";
			}
			condition.setRequired(Integer.parseInt(required));
			condition.setSearch(Integer.parseInt(jsonObject.get("search").toString()));
			condition.setSort(Integer.parseInt(jsonObject.get("sort").toString()));
			condition.setEntityCode(humpStr);
			conditionInfoList.add(condition);
		}
		
		return conditionInfoList;
	}
}
