<#-- CHART CONFIGURATION -->
<#assign
    chartType = 'pie' <#-- donut, pie -->
    monochrome = true <#-- monochromatic Chart -->
    monoColor = '#f48225'
    palette = 'palette10' <#-- pallete1-10. It only works if monochrome = false -->
    paletteMode = 'light' <#-- dark, light -->
/>

<#-- ------------------- -->

<#assign 
    series = "["
    labels = "["
    types = "["
/>

<#if entries?has_content>
	<#list entries as entry>
	    <#assign
    		series += entry.getFrequency()
    	    labels += "'"
    		labels += entry.getTypeName()
    	    labels += "'"
    	    types += "'"
    	    types += entry.getAssetType()
    	    types += "'"
	    />
	    <#if !entry?is_last >
	        <#assign
	            series += ","
	            labels += ","
	            types += ","
	        />
	   </#if>
	</#list>
<#assign 
    series += "]"
    labels += "]"
    types += "]"
/>
    <div class="panel panel-default search-facet lfr-panel lfr-panel-extended" id="INSTANCE_${template_id}_facetTypeChart">
        <div class="panel-heading" id="INSTANCE_${template_id}_facetTypePanelHeader" role="tab">
    		<div class="h4 panel-title">
    			<a aria-controls="INSTANCE_${template_id}_facetTypePanelContent" aria-expanded="true" class="collapse-icon collapse-icon-middle " data-parent="#INSTANCE_${template_id}_facetTypeChart" data-toggle="liferay-collapse" href="#INSTANCE_${template_id}_facetTypePanelContent" role="button">
					<@liferay_ui["message"] key="type" />
					<span class="collapse-icon-closed" id="ored____"><svg aria-hidden="true" class="lexicon-icon lexicon-icon-angle-right" focusable="false"><use href="/o/classic-theme/images/clay/icons.svg#angle-right"></use></svg></span>
					<span class="collapse-icon-open" id="fehs____"><svg aria-hidden="true" class="lexicon-icon lexicon-icon-angle-down" focusable="false"><use href="/o/classic-theme/images/clay/icons.svg#angle-down"></use></svg></span>
				</a>
    		</div>
    	</div>
    	<div aria-labelledby="INSTANCE_${template_id}_facetTypePanelHeader" class="collapse panel-collapse show" id="INSTANCE_${template_id}_facetTypePanelContent" role="tabpanel">
		    <div class="panel-body" id="INSTANCE_${template_id}_facetTypePanelBody">
	            <div id="chart-${template_id}"></div>
		    </div>
		</div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
	<script>
	     const typeCurrentURL = new URL(Liferay.ThemeDisplay.getPortalURL() + Liferay.currentURL);
    	 const typeLabels = ${labels};
    	 const typeParamValues = typeCurrentURL.searchParams.getAll('type');
    	 const typeTypeValues = ${types};
    	 
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
            	        if (typeParamValues.length > 0 ) {
            	            // Create clear button
            	            let clearButtonContent = document.createElement('span');
            	            clearButtonContent.classList.add('lfr-btn-label');
            	            clearButtonContent.innerHTML = '<@liferay_ui["message"] key="clear" />';
            	            let clearButton = document.createElement('button');
            	            clearButton.classList.add('btn', 'btn-link', 'btn-unstyled', 'facet-clear-btn', 'btn-secondary');
            	            clearButton.addEventListener('click', (event) => {
            	                let linkURL = typeCurrentURL;
            	                linkURL.searchParams.delete('type');
            	                window.location.href = linkURL;
            	            })
            	            clearButton.appendChild(clearButtonContent);
            	            document.getElementById('INSTANCE_${template_id}_facetTypePanelBody').appendChild(clearButton);
            	            
            	            // Preselect values in URL
                            typeParamValues.forEach((param) => {
                                if (typeTypeValues.includes(param)) {
                                    chartContext.toggleDataPointSelection(typeTypeValues.indexOf(param));
                                }
                            }); 
            	        } 
            	    },
                    dataPointSelection: (event, chartContext, config) => {
                        
                        let typeValue = typeTypeValues[config.dataPointIndex];
                        let linkURL = typeCurrentURL;
                        
                        if (! typeParamValues.includes(typeValue)) {
                            linkURL.searchParams.append('type', typeValue);
                            window.location.href = linkURL;
                        } else {
                            if (event && event.type === "mousedown") {
                                let paramsIncluded = linkURL.searchParams.getAll('type');

                                paramsIncluded.forEach((value, index, object) => {
                                    if (value === typeValue) {
                                        object.splice(index, 1);
                                    }
                                });

                                linkURL.searchParams.delete('type');
                                
                                if (typeof paramsIncluded !== "undefined" && paramsIncluded.length > 0) {
                                    paramsIncluded.forEach((pValue) => {
                                        linkURL.searchParams.append('type', pValue);
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
        	labels: typeLabels,
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