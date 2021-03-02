setwd('/var/www/forge2/production/src/html/files/0xD0F46DAC7B7B11EB9F6FC1A5B4A874F8')
results <- read.table('RA_project.GWAS.erc.chart.tsv.gz', header = TRUE, sep='\t')
results <- subset(results, T, select = c('Cell', 'Tissue', 'Datatype', 'Accession', 'Pvalue', 'Qvalue', 'Probe'))
require(rCharts)
dt <- dTable(
    results,
    sScrollY = '600',
    bPaginate = F,
    sScrollX = '100%',
    width = '680px'
)
dt$save('RA_project.GWAS.erc.table.html', cdn = F)
