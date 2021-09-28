<#-- CHART CONFIGURATION -->
<#assign
    chartType = 'pie' <#-- donut, pie -->
    monochrome = true
    monoColor = '#0b5fff'
    palette = 'palette10' <#-- pallete1-10. It only works if monochrome = false -->
    paletteMode = 'light' <#-- dark, light -->
/>
<#-- ------------------- -->

<#assign 
    series = "["
    labels = "["
/>

<#if entries?has_content>
	<#list entries as entry>
	    <#assign
    		series += entry.getFrequency()
    	    labels += "'"
    		labels += entry.getUserName()
    	    labels += "'"
	    />
	    <#if !entry?is_last >
	        <#assign
	            series += ","
	            labels += ","
	        />
	   </#if>
	</#list>
<#assign 
    series += "]"
    labels += "]"
/>
    <div class="panel panel-default search-facet lfr-panel lfr-panel-extended" id="INSTANCE_${template_id}_facetUserChart">
        <div class="panel-heading" id="INSTANCE_${template_id}_facetUserPanelHeader" role="tab">
    		<div class="h4 panel-title">
    			<a aria-controls="INSTANCE_${template_id}_facetUserPanelContent" aria-expanded="true" class="collapse-icon collapse-icon-middle " data-parent="#INSTANCE_${template_id}_facetUserChart" data-toggle="liferay-collapse" href="#INSTANCE_${template_id}_facetUserPanelContent" role="button">
					<@liferay_ui["message"] key="user" />
					<span class="collapse-icon-closed" id="ored____"><svg aria-hidden="true" class="lexicon-icon lexicon-icon-angle-right" focusable="false"><use href="/o/classic-theme/images/clay/icons.svg#angle-right"></use></svg></span>
					<span class="collapse-icon-open" id="fehs____"><svg aria-hidden="true" class="lexicon-icon lexicon-icon-angle-down" focusable="false"><use href="/o/classic-theme/images/clay/icons.svg#angle-down"></use></svg></span>
				</a>
    		</div>
    	</div>
    	<div aria-labelledby="INSTANCE_${template_id}_facetUserPanelHeader" class="collapse panel-collapse show" id="INSTANCE_${template_id}_facetUserPanelContent" role="tabpanel">
		    <div class="panel-body" id="INSTANCE_${template_id}_facetUserPanelBody">
	            <div id="chart-${template_id}"></div>
		    </div>
		</div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
	<script>
    	 const uCurrentURL = new URL(Liferay.ThemeDisplay.getPortalURL() + Liferay.currentURL);
    	 const userLabels = ${labels};
    	 const userParamValues = uCurrentURL.searchParams.getAll('user');
    	 
    	 const options${template_id} = {
        	chart: {
        		id: "chart-${template_id}",
        		type: '${chartType}',
                toolbar: {
                  autoSelected: "pan",
                  show: false
                },
            	events: {
            	    mounted: (chartContext, options) => {
            	        if (userParamValues.length > 0 ) {
            	            // Create clear button
            	            let clearButtonContent = document.createElement('span');
            	            clearButtonContent.classList.add('lfr-btn-label');
            	            clearButtonContent.innerHTML = '<@liferay_ui["message"] key="clear" />';
            	            let clearButton = document.createElement('button');
            	            clearButton.classList.add('btn', 'btn-link', 'btn-unstyled', 'facet-clear-btn', 'btn-secondary');
            	            clearButton.addEventListener('click', (event) => {
            	                let linkURL = uCurrentURL;
            	                linkURL.searchParams.delete('user');
            	                window.location.href = linkURL;
            	            })
            	            clearButton.appendChild(clearButtonContent);
            	            document.getElementById('INSTANCE_${template_id}_facetUserPanelBody').appendChild(clearButton);
            	            
            	            // Preselect values in URL
                            userParamValues.forEach((param) => {
                                if (userLabels.includes(param)) {
                                    console.log(param);
                                    chartContext.toggleDataPointSelection(userLabels.indexOf(param));
                                }
                            }); 
            	        } 
            	    },
                    dataPointSelection: (event, chartContext, config) => {
                        
                        let userValue = config.w.config.labels[config.dataPointIndex];
                        let linkURL = uCurrentURL;
                        
                        if (! userParamValues.includes(userValue)) {
                            linkURL.searchParams.append('user', userValue);
                            window.location.href = linkURL;
                        } else {
                            if (event && event.type === "mousedown") {
                                let paramsIncluded = linkURL.searchParams.getAll('user');

                                paramsIncluded.forEach((value, index, object) => {
                                    if (value === userValue) {
                                        object.splice(index, 1);
                                    }
                                });

                                linkURL.searchParams.delete('user');
                                
                                if (typeof paramsIncluded !== "undefined" && paramsIncluded.length > 0) {
                                    paramsIncluded.forEach((pValue) => {
                                        linkURL.searchParams.append('user', pValue);
                                    })
                                }
                                
                                window.location.href = linkURL;
                            }
                        }
                    }
                }
        	},
        	theme: {
        	  <#if monochrome >
        		monochrome: {
        			enabled: true,
        			color: '${monoColor}',
        			shadeTo: '${paletteMode}',
        			shadeIntensity: 0.65
        		}
              <#else>
                  mode: '${paletteMode}', 
                  palette: '${palette}', 
              </#if>
        	},
        	series: ${series},
        	labels: userLabels,
        	legend: {
        		show: false
        	},
        	dataLabels: {
        		enabled: true,
                formatter(val, opts) {
        			const name = opts.w.globals.labels[opts.seriesIndex]
        			return [name, val.toFixed(1) + '%']
        		}
        	},
        	states: {
        	    active: {
        	        allowMultipleDataPointsSelection: true
        	    }
        	}
        }
        
        var chart${template_id} = new ApexCharts(document.querySelector("#chart-${template_id}"), options${template_id});
        
        chart${template_id}.render();
	 </script>
</#if>