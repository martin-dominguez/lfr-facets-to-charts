<#if entries?has_content>
    <style>
        .custom-folder-facet h3 a {
            border-bottom: solid 2px var(--primary);
            width: fit-content;
            text-transform: uppercase;
            font-size: 12px;
            font-weight: 700;
            line-height: 12px;
            color: var(--body-color);
            padding-right: 0px;
        }
        .custom-folder-facet h3 .lexicon-icon {
            font-size: 16px;
            font-weight: 700;
            color: var(--primary);
        }
        .custom-folder-facet .sticker {
            color: var(--primary);
            background-color: rgba(175, 120, 255, 0.2);
        }
        .custom-folder-facet .folder-facet-card {
            background-color: transparent !important;
            border-radius: var(--border-radius-lg);
            transition: box-shadow .5s ease-in-out;
            border-width: 1px;
            box-shadow: none;
        }
        .custom-folder-facet .folder-facet-card:hover {
            box-shadow: var(--box-shadow);
            background-color: transparent !important;
        }
        .custom-folder-facet .card-body {
            padding: 26px 1rem;
            
        }
        .custom-folder-facet .folder-facet-card.selected {
            background-color: var(--primary) !important;
        }
        .custom-folder-facet .folder-facet-card.selected .card-title a,
        .custom-folder-facet .folder-facet-card.selected .sticker {
            color: white !important;
        }
    </style>
    
    <#assign 
        params = []
        firstParam = true
        />
    <#if themeDisplay.getURLCurrent()?contains("?")>
        <#assign
            firstParam = false
            params = themeDisplay.getURLCurrent()?split("?")[1]?split("&")
        />
    </#if>
    
    <div class="custom-folder-facet container">        
        <div id="INSTANCE_${template_id}_facetFolderPanelHeader" role="tab">
            <h3 class="mb-4">
            <a aria-controls="INSTANCE_${template_id}_facetFolderPanelContent" aria-expanded="true" class="collapse-icon" data-toggle="liferay-collapse" href="#INSTANCE_${template_id}_facetFolderPanelContent" role="button">
                <@liferay_ui["message"] key="folders"/>
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
        <div aria-labelledby="INSTANCE_${template_id}_facetFolderPanelHeader" class="collapse panel-collapse show" id="INSTANCE_${template_id}_facetFolderPanelContent" role="tabpanel">
            <div class="row flex-wrap">
        	    <#list entries as entry>
            	    <#assign 
            	        linkURL = themeDisplay.getURLCurrent()
    	                fullParam = "folder="
    	                fullParam += entry.getFolderId()
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
            	            linkURL += "folder="
            	            linkURL += entry.getFolderId() /> 
            	    </#if>
            	    <div class="col-lg-6 col-xl-6 ${(entry?index > 3)?string('folder-entry-hidden hide','')}">
                        <@liferay_frontend["horizontal-card"]
                        	text= "${entry.getDisplayName()}"
                        	url = "${linkURL}"
                        	cssClass = "folder-facet-card ${selected?string('selected','')}"
                        >
                            <@liferay_frontend["horizontal-card-col"]>
                				<@liferay_frontend["horizontal-card-icon"]
                					icon="folder"
                				/>
                	        </@>
                        </@>
                    </div>
        	    </#list>
    	    </div>
            <#if entries?size &gt; 4>
                <a class="folders-more-link font-weight-bold"><span class="folders-more-text"><@liferay_ui["message"] key="more"/></span><span class="folders-more-text hide"><@liferay_ui["message"] key="hide"/></span>...</a>
            </#if>
        </div>
    </div>
    
    <script>
        const foldersMoreLink = document.querySelector('.folders-more-link');
        foldersMoreLink.addEventListener('click', (e) => {
            document.querySelectorAll('.folder-entry-hidden').forEach(
                entry => entry.classList.toggle('hide')
            );
            document.querySelectorAll('.folders-more-text').forEach(
                entry => entry.classList.toggle('hide')
            );
        });
    </script>
</#if>