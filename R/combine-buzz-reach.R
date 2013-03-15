tmp.buzz <- read.csv(paste0(procpath,'buzz-temporal-output.csv'))

names(tmp.buzz)[1] <- "Ident"
names(tmp.buzz)[2:44] <- obs.dates

pvalue <- read.csv(paste0(procpath,'p-value.csv'))

tmp.influence <- addReachToBuzz(buzz.analysis, tmp.buzz)

write.csv(tmp.influence, paste0(procpath, 'influence-temporal.csv'))

ranked.user.ids <- rankTimeSeriesUsers(tmp.influence, obs.dates, 1, TRUE)
ranked.pval.user.ids <- rankTimeSeriesUsers(pvalue, obs.dates, 1, TRUE)
write.csv(ranked.user.ids, paste0(procpath, 'influence-ranked-ids-temporal.csv'))
write.csv(ranked.pval.user.ids, paste0(procpath, 'pvalue-ranked-ids-temporal.csv'))

ranked.users <- rankTimeSeriesUsers(tmp.influence, obs.dates, 1, FALSE)
ranked.pval.users <- rankTimeSeriesUsers(pvalue, obs.dates, 1, FALSE)
write.csv(ranked.users, paste0(procpath, 'influence-ranked-temporal.csv'))
write.csv(ranked.pval.users, paste0(procpath, 'pvalue-ranked-temporal.csv'))

rank.cor <- rep(0,43)

for(i in 1:43){
  rank.cor[i] <- cor(ranked.user.ids[ ,i],ranked.pval.user.ids[ ,i], method="spearman")
}

plot(rank.cor, ylim=c(-1,1), xlab="Weeks", ylab=expression(paste("Spearman ", rho)))
lines(rep(mean(rank.cor),43), col="red", lty=1)
legend("topright",legend=expression(paste("Mean ", rho)), col="red", lty=1)