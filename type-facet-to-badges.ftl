<#if entries?has_content>
    <style>
        .custom-type-facet h3 a {
            border-bottom: solid 2px var(--primary);
            width: fit-content;
            text-transform: uppercase;
            font-size: 12px;
            font-weight: 700;
            line-height: 12px;
            color: var(--body-color);
            padding-right: 0px;
        }
        .custom-type-facet h3 .lexicon-icon {
            font-size: 16px;
            font-weight: 700;
            color: var(--primary);
        }
        .custom-type-facet .badge {
            height: 80px;
            width: 100%;
            justify-content: center;
        }
        .custom-type-facet .badge-item {
            width: 100px;
            font-size: 26px;
            align-items: center;
            border-radius: 10px;
            border-width: 0;
            transition: all .5s ease-in-out;
        }
        .custom-type-facet .type-link .badge-item::before {
            border-radius: 10px !important;
        }
        .custom-type-facet .type-link:hover .badge-item {
            border: solid 2px;
            box-shadow: var(--box-shadow);
        }
        .custom-type-facet .type-link .badge-item.selected {
            border: solid 2px;
        }
        .custom-type-facet h4 {
            text-align: center;
            max-width: 120px;
            font-size: 15px;
            font-weight: 700;
            line-height: 19px;
            margin-top: 12px;
        }
        .custom-type-facet h4 sup {
            color: #6B6C7E;
            font-weight: 700;
        }
        .custom-type-facet .panel-collapse > div.autofit-row {
            justify-content: space-evenly;
        }
    </style>
    <#assign 
        params = []
        firstParam = true
        colors = ['primary', 'secondary', 'info', 'success', 'warning', 'danger']
        />
    <#if themeDisplay.getURLCurrent()?contains("?")>
        <#assign
            firstParam = false
            params = themeDisplay.getURLCurrent()?split("?")[1]?split("&")
        />
    </#if>
    <div class="custom-type-facet container">
        <div id="INSTANCE_${template_id}_facetTypePanelHeader" role="tab">
            <h3 class="mb-4">
                <a aria-controls="INSTANCE_${template_id}_facetTypePanelContent" aria-expanded="true" class="collapse-icon" data-toggle="liferay-collapse" href="#INSTANCE_${template_id}_facetTypePanelContent" role="button">
                    <@liferay_ui["message"] key="types"/>
                    <@clay["icon"] 
                        className = "collapse-icon-closed"
                        symbol="angle-right"
                    />
                    <@clay["icon"] 
                        className = "collapse-icon-open"
                        symbol="angle-down"
                    />
        		 </a/>
            </h3>
        </div>
        <div aria-labelledby="INSTANCE_${template_id}_facetTypePanelHeader" class="collapse panel-collapse show" id="INSTANCE_${template_id}_facetTypePanelContent" role="tabpanel">
            <div class="autofit-row flex-wrap">
        	<#list entries as entry>
        	    <#assign icon = "folder">
        	    <#if !entry.getTypeName()?contains("Folder") >
        	        <#if entry.getTypeName()?contains("Form")>
        	            <#assign icon = "forms" />
        	        <#elseif entry.getTypeName()?contains("Web Content")>
        	            <#assign icon = "web-content" />
        	        <#else>
        	            <#assign icon = entry.getTypeName()?split(" ")[0]?lower_case />
        	        </#if>
        	   </#if>
        	    
        	    <#assign color = colors[entry?index%colors?size] />
        	    
        	    <#assign 
        	        linkURL = themeDisplay.getURLCurrent()
                    fullParam = "type="
                    fullParam += entry.getAssetType()
                    selected = false
                   />
                   
        	    <#if params?seq_contains(fullParam)>
        	        <#assign 
        	            selected=true 
        	            linkURL = themeDisplay.getURLCurrent()?split("?")[0]
        	            firstParamControl = false
        	        />
        	        <#list params as param>
        	            <#if !(param == fullParam)>
        	                <#if !firstParamControl >
        	                    <#assign 
        	                        linkURL += "?" 
        	                        firstParamControl = true
        	                    />
        	                <#else>
        	                    <#assign linkURL += "&" />
        	                </#if>
        	                <#assign linkURL += param />
        	            </#if>
        	        </#list>
        	    <#else>
        	        <#assign linkURL += firstParam?string("?","&") 
        	            linkURL += "type="
        	            linkURL += entry.getAssetType() /> 
        	    </#if>
        	    <div class="autofit-col autofit-col-shrink align-items-center">
                    <a class="type-link" href="${linkURL}">
                        <span class="badge mi-badge-${color}">
                            <span class="badge-item badge-item-expand border-${color} ${selected?string('selected','')}">
                                <@clay["icon"] 
                                    className = "list-badge"
                                    symbol=icon
                                />
                            </span>
                        </span>
                    </a>
                    <h4>${entry.getTypeName()}<sup class="ml-1">${entry.getFrequency()}</sup></h4> 
        	    </div>
        	</#list>
    	</div>
        </div>
    </div>
</#if>