[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
![GitHub top language][top-lenguage-shield]
[![LinkedIn][linkedin-shield]][linkedin-url]

# About This Project

**lfr-facets-to-charts** is a collection of Widget Display Templates to convert Liferay's Search Facets to Charts.

![lfr-facets-to-charts][lfr-facets-to-charts-img]

## Built With

These Widget Display Templates have been build using the following software:
* [ApexCharts](https://apexcharts.com/)

# Getting Started

## Prerequisites

* These Widget Display Templates are compatible with **Liferay 7.3**
* All the requiered libraries will be loaded in each Widget Display Template.

## Configuration

In the first lines of each file you'll find a configuration section:
```
<#-- CHART CONFIGURATION -->
<#assign
    chartType = 'pie' <#-- donut, pie -->
    monochrome = true <#-- monochromatic Chart -->
    monoColor = '#b95000'
    palette = 'palette10' <#-- pallete1-10. It only works if monochrome = false -->
    paletteMode = 'light' <#-- dark, light -->
/>

<#-- ------------------- -->
```

The variables that can be set are:
* chartType: only two charts are allowed: pie or donut
* monochrome: slices colors will be a monochromatic scale
* monoColor: color for monochromatic scale
* pallete: this option only works if you selected `monochrome = 'false'` you can choose one of the palettes avaliable in [ApexCharts](https://apexcharts.com/docs/options/theme/#palette)
* paleteMode: sets the light palette or the dark palette. It also works in monochrome charts to shade the colors to light or to dark.

# Usage

1. Import the template as a new Widget Display Template.
2. Add a facet to your page
3. Select this template as Display Template

# TODO List

* When an element is selected you can see this error in JS console: `Error: <path> attribute d: Expected moveto path command ('M' or 'm'), "null"`. It is due of an [ApexCharts bug](https://github.com/apexcharts/apexcharts.js/issues/2258)
* During page editing, the code is loaded twice, so you'll get JS errors and the charts won't be visible while editing.

**PRs, issues and comments will be welcomed**

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/martin-dominguez/lfr-facets-to-charts.svg
[contributors-url]: https://github.com/martin-dominguez/lfr-facets-to-charts/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/martin-dominguez/lfr-facets-to-charts.svg
[forks-url]: https://github.com/martin-dominguez/lfr-facets-to-charts/network/members
[stars-shield]: https://img.shields.io/github/stars/martin-dominguez/lfr-facets-to-charts.svg
[stars-url]: https://github.com/martin-dominguez/lfr-facets-to-charts/stargazers
[issues-shield]: https://img.shields.io/github/issues/martin-dominguez/lfr-facets-to-charts.svg
[issues-url]: https://github.com/martin-dominguez/lfr-facets-to-charts/issues
[top-lenguage-shield]: https://img.shields.io/github/languages/top/martin-dominguez/lfr-facets-to-charts
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/-martin-dominguez/
[lfr-facets-to-charts-img]: img/lfr-facets-to-charts.gif