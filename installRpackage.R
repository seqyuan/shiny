pas <- c('shiny', 
	'markdown', 
	'DT',
	'BiocManager',
	'ggplot2',
	'shinydashboard', 
	'shinyFiles',
	'shinythemes',
	'ggrepel', 
	'gridExtra', 
	'RColorBrewer',
	'devtools', 
	'cowplot', 
	'Cairo' , 
	'reticulate', 
	'dplyr',
	'patchwork')


install.packages(pas)
BiocManager::install(c('ComplexHeatmap'))
remotes::install_version("Matrix",version = "1.6-1.1", INSTALL_opts = '--no-lock', force=TRUE, upgrade='never')
print('SeuratObject')
remotes::install_version("SeuratObject", "4.1.4", repos = c("https://satijalab.r-universe.dev", getOption("repos")), upgrade='never')
print('Seurat')
remotes::install_version(package = 'Seurat', version = package_version('4.4.0'), upgrade='never')
