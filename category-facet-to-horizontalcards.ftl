<#if entries?has_content>
    <style>
        .custom-category-facet h3 a {
            border-bottom: solid 2px var(--primary);
            width: fit-content;
            text-transform: uppercase;
            font-size: 12px;
            font-weight: 700;
            line-height: 12px;
            color: var(--body-color);
            padding-right: 0px;
        }
        .custom-category-facet h3 .lexicon-icon {
            font-size: 16px;
            font-weight: 700;
            color: var(--primary);
        }
        .custom-category-facet .sticker {
            color: var(--primary);
            background-color: rgba(175, 120, 255, 0.2);
        }
        .custom-category-facet .category-facet-card {
            background-color: transparent !important;
            border-radius: var(--border-radius-lg);
            transition: box-shadow .5s ease-in-out;
            border-width: 1px;
            box-shadow: none;
        }
        .custom-category-facet .category-facet-card:hover {
            box-shadow: var(--box-shadow);
            background-color: transparent !important;
        }
        .custom-category-facet .card-body {
            padding: 26px 1rem;
            
        }
        .custom-category-facet .category-facet-card.selected {
            background-color: var(--primary) !important;
        }
        .custom-category-facet .category-facet-card.selected .card-title a,
        .custom-category-facet .category-facet-card.selected .sticker {
            color: white !important;
        }
    </style>
    <#assign assetCategoryServiceUtil = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryLocalService") />
    
    <#assign 
        vocabularyId = 41822
        params = []
        firstParam = true
        />
    <#if themeDisplay.getURLCurrent()?contains("?")>
        <#assign
            firstParam = false
            params = themeDisplay.getURLCurrent()?split("?")[1]?split("&")
        />
    </#if>
    
    <div class="custom-category-facet container">        
        <div id="INSTANCE_${template_id}_facetCategoryPanelHeader" role="tab">
            <h3 class="mb-4">
            <a aria-controls="INSTANCE_${template_id}_facetCategoryPanelContent" aria-expanded="true" class="collapse-icon" data-toggle="liferay-collapse" href="#INSTANCE_${template_id}_facetCategoryPanelContent" role="button">
                <@liferay_ui["message"] key="categories"/>
                <@clay["icon"] 
                    className = "collapse-icon-closed"
                    symbol="angle-right"
                />
                <@clay["icon"] 
                    className = "collapse-icon-open"
                    symbol="angle-down"
                />
            </a>
        </h3>
        </div>
        <div aria-labelledby="INSTANCE_${template_id}_facetCategoryPanelHeader" class="collapse panel-collapse show" id="INSTANCE_${template_id}_facetCategoryPanelContent" role="tabpanel">
            <div class="row flex-wrap">
            	<#list entries as entry>
            	    <#assign 
            	        category = assetCategoryServiceUtil.getAssetCategory(entry.getAssetCategoryId()) 
            	    />
            	    
            	    <#if vocabularyId == category.getVocabularyId()>
                	    <#assign 
                	        linkURL = themeDisplay.getURLCurrent()
        	                fullParam = "category="
        	                fullParam += entry.getAssetCategoryId()
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
                	            linkURL += "category="
                	            linkURL += entry.getAssetCategoryId() /> 
                	    </#if>
                	    <div class="col-lg-3 col-xl-3 col-md-6 col-sm-12">
                            <@liferay_frontend["horizontal-card"]
                            	text= "${entry.getDisplayName()}"
                            	url = "${linkURL}"
                            	cssClass = "category-facet-card ${selected?string('selected','')}"
                            >
                                <@liferay_frontend["horizontal-card-col"]>
                    				<@liferay_frontend["horizontal-card-icon"]
                    					icon="breadcrumb"
                    				/>
                    	        </@>
                            </@>
                        </div>
                    </#if>
            	</#list>
    	    </div>
        </div>
    </div>
</#if>