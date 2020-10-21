<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div lay-filter="${entityName}EditFrom" class="layui-form" style="padding: 20px 0 0 0;">
	<input type="hidden" name="id" value="${"$"}{${entityName}.id}" />
	<#list conditionInfoList as conditionIn>
		<#if conditionIn.web == 1>
			<#if conditionIn.type == 1>
	<div class="layui-form-item">
		<div class="layui-col-md11">
			<label class="layui-form-label">${conditionIn.name}：</label>
			<div class="layui-input-block">
				<#if conditionIn.required == 1>
				<input name="${conditionIn.entityCode}" value="${"$"}{${entityName}.${conditionIn.entityCode}}" 
					class="layui-input" lay-verify="required">
				<#elseif conditionIn.required == 0>
				<input name="${conditionIn.entityCode}" value="${"$"}{${entityName}.${conditionIn.entityCode}}" 
					class="layui-input">
				</#if>
			</div>
		</div>
	</div>
			</#if>
			<#if conditionIn.type == 2>
	<div class="layui-form-item">
		<div class="layui-col-md11">
			<label class="layui-form-label">${conditionIn.name}：</label>
			<div class="layui-input-block">
				<input name="${conditionIn.entityCode}" value="${"$"}{${entityName}.${conditionIn.entityCode}}" 
					class="layui-input" lay-verify="required">
			</div>
			<div class="layui-input-block" >
	        	<select name="${conditionIn.entityCode}">                
		            <c:forEach var="${conditionIn.entityCode}" items="${conditionIn.entityCode}List" >
		            <option name="${conditionIn.entityCode} value="" "></option>
		            </c:forEach>
	            </select>
	     	</div>
     	</div>
	</div>
			</#if>
			<#if conditionIn.type == 3>
	<div class="layui-form-item">
		<div class="layui-col-md11">
			<label class="layui-form-label">${conditionIn.name}：</label>
			<div class="layui-input-block">
				<c:forEach var="conditionIn.entityCode" items="${conditionIn.entityCode}List">
				<input type="radio" name="${conditionIn.entityCode}">
				</c:forEach>
			</div>
		</div>
	</div>
			</#if>
			<#if conditionIn.type == 4>
	<div class="layui-form-item">
		<div class="layui-col-md11">
			<label class="layui-form-label">${conditionIn.name}：</label>
			<div class="layui-form-item">
			    <div class="layui-input-block">
				    <c:forEach var="conditionIn.entityCode" items="${conditionIn.entityCode}List">
					<input type="checkbox" name="${conditionIn.entityCode}">
					</c:forEach>
			    </div>
		  	</div>
		</div>
	</div>
			</#if>
			<#if conditionIn.type == 5>
	<div class="layui-form-item">
		<div class="layui-col-md11">
			<label class="layui-form-label">${conditionIn.name}：</label>
			<div class="layui-input-block">
	   			<#if conditionIn.required == 1>
				<textarea name="${conditionIn.entityCode}" placeholder="请输入内容" 
					class="layui-textarea" lay-verify="required">${"$"}{${entityName}.${conditionIn.entityCode}}</textarea>
				<#elseif conditionIn.required == 0>
				<textarea name="${conditionIn.entityCode}" placeholder="请输入内容" 
					class="layui-textarea">${"$"}{${entityName}.${conditionIn.entityCode}}</textarea>
				</#if>
	 		</div>
	 	</div>
	</div>
			</#if>
			<#if conditionIn.type == 6>
	<div class="layui-form-item">
		<div class="layui-col-md11">
			<label class="layui-form-label">${conditionIn.name}：</label>
			<div class="layui-input-block">
				<#if conditionIn.required == 1>
				<input type="text" name = "${conditionIn.entityCode}" value="${"$"}{${entityName}.${conditionIn.entityCode}}" 
					class="layui-input" id="${conditionIn.entityCode}" placeholder="请输入时间" lay-verify="required">
				<#elseif conditionIn.required == 0>
				<input type="text" name = "${conditionIn.entityCode}" value="${"$"}{${entityName}.${conditionIn.entityCode}}" 
					class="layui-input" id="${conditionIn.entityCode}" placeholder="请输入时间">
				</#if>
	 		</div>
 		</div>
	</div>
			</#if>
			<#if conditionIn.type == 7>
	<div class="layui-form-item">
		<div class="layui-col-md11">
			<label class="layui-form-label">${conditionIn.name}：</label>
			<div class="layui-input-block">
				<select name="${conditionIn.entityCode}" lay-filter="">
				<c:forEach var="dict" items="${"$"}{${conditionIn.entityCode}List}">
					<option value="${"$"}{dict.dictKey }" ${"$"}{dict.dictKey == ${entityName}.${conditionIn.entityCode} ? "selected" : ""}> ${"$"}{dict.dictValue }</option>
				</c:forEach>
				</select>
	 		</div>
 		</div>
	</div>
			</#if>
		</#if>
	</#list>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="${entityName}EditBtn" value="确认">
	</div>
</div>
