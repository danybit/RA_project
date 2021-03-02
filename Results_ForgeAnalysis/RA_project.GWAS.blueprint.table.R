setwd('/var/www/forge2/production/src/html/files/0xDE219F1E7B7A11EB8005BCA4B4A874F8')
results <- read.table('RA_project.GWAS.blueprint.chart.tsv.gz', header = TRUE, sep='\t')
results <- subset(results, T, select = c('Cell', 'Tissue', 'Datatype', 'Accession', 'Pvalue', 'Qvalue', 'Probe'))
require(rCharts)
dt <- dTable(
    results,
    sScrollY = '600',
    bPaginate = F,
    sScrollX = '100%',
    width = '680px'
)
dt$save('RA_project.GWAS.blueprint.table.html', cdn = F)
