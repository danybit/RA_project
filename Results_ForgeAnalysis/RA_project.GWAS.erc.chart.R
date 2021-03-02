setwd('/var/www/forge2/production/src/html/files/0xD0F46DAC7B7B11EB9F6FC1A5B4A874F8')
results<-read.table('RA_project.GWAS.erc.chart.tsv.gz', header=TRUE,sep='\t')

# Class splits the data into non-significant, marginally significant and significant according to 0.05 and 0.01 (in -log10 scale)
results$Class <- cut(results$Pvalue, breaks =c(0, 0.01, 0.05, 1)/length(unique(results[,'Tissue'])), labels=FALSE, include.lowest=TRUE)

# Class splits the data into non-significant, marginally significant and significant according to q-value (B-Y FDR adjusted)
results$Class2 <- cut(results$Qvalue, breaks =c(0, 0.01, 0.05, 1), labels=FALSE, include.lowest=TRUE)

# Re-order the entries according to tissue first and then cell type/line
tissue.cell.order <- unique(results[, c('Tissue', 'Cell')])
tissue.cell.order <- tissue.cell.order[order(tissue.cell.order[,1], tissue.cell.order[,2]), ]
# Collapse into a single string (to support same cell type in different tissues)
tissue.cell.order2 <- apply(tissue.cell.order, 1, paste, collapse = ' -- ')
results$TissueCell <- apply(results[, c('Tissue', 'Cell')], 1, paste, collapse = ' -- ')
results$TissueCell <- factor(results$TissueCell, levels=tissue.cell.order2)

# Plot an empty chart first
pdf('RA_project.GWAS.erc.chart.pdf', width=22.4, height=8)
ymax = max(-log10(results$Pvalue), na.rm=TRUE)*1.1
ymin = -0.1
par(mar=c(15.5,4,3,1)+0.1)
plot(NA,ylab='', xlab='', main='SNPs analyzed across samples for erc RA_project',
    ylim=c(ymin,ymax), las=2, pch=19, col = results$Class2, xaxt='n', xlim=c(0,length(levels(results$TissueCell))), cex.main=2)

# Add horizontal guide lines for the Y-axis
abline(h=par('yaxp')[1]:par('yaxp')[2],lty=1, lwd=0.1, col='#e0e0e0')

# Add vertical lines and labels to separate the tissues
tissues <- c(0, cumsum(summary(tissue.cell.order[,'Tissue'])))
abline(v=tissues[2:(length(tissues)-1)]+0.5, lty=6, col='grey')
text((tissues[1:(length(tissues)-1)] + tissues[2:length(tissues)]) / 2 + 0.5, ymax, names(tissues[2:length(tissues)]), col='grey', adj=1, srt=90, cex=1.2) 

# Add points (internal color first)
palette(c('red', 'palevioletred1', 'white'))
points(results$TissueCell, -log10(results$Pvalue), pch=19, col = results$Class2, xaxt='n')

# Add contour to the points
palette(c('black', 'palevioletred1', 'steelblue3'))
points(results$TissueCell, -log10(results$Pvalue), pch=1, col = results$Class2, xaxt='n')

# Add X-axis (use cell name only and not TissueCell)
axis(1, seq(1,length(tissue.cell.order[,2])), labels=tissue.cell.order[,2], las=2, cex.axis=0.67)
mtext(1, text='Cell', line=14, cex=1.4)
mtext(2, text='-log10 binomial p-value', line=2, cex=1.4)

# Add legend (internal color first)
palette(c('white', 'palevioletred1', 'red'))
legend('topleft', pch=19, legend=c('q < 0.01', 'q < 0.05', 'non-sig'), col = 3:1, cex=0.8, inset=c(0.001, 0.005), box.col='white', title='FDR q-value', text.col='white', bg='white')

# Add contour to the points in the legend
palette(c('steelblue3', 'palevioletred1', 'black'))
legend('topleft', pch=1, legend=c('q < 0.01', 'q < 0.05', 'non-sig'), col = 3:1, cex=0.8, inset=c(0.001, 0.005), box.col='darkgrey', title='FDR q-value')

palette('default')
dev.off()
