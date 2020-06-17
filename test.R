viro_sra <- readSraRunInfo("../sra/viro_SraRunInfo.csv")

sumWheres_all <- paste("../summary_files/", system( paste0("ls ", "../summary_files/"), intern = T), sep="/")

summary_files <- paste(viro_sra@runInfo$Run, "summary", sep=".")

sumWheres <- paste("../summary_files/", summary_files, sep="/")

#remove files that are absent in the specified folder
files_to_analyze <- intersect(sumWheres_all, sumWheres)
files_to_analyze <- files_to_analyze[1:10]

#parse Families
parseSummaryFiles(files_to_analyze, outputFolder="../viro/viro_F/", parseFamily=T)

#parse Accessions
parseSummaryFiles(files_to_analyze, outputFolder="../viro/viro_Acc/", parseFamily=F)

#read all family dfs
#DATA_PATH='../viro/viro_F/'
DATA_PATH='../temp_folder_viro_F/'
sumWheres <- paste0( DATA_PATH,
                     system( paste0("ls ", DATA_PATH), intern = T ))

#read all columns
viro <- readDFs(sumWheres, all=T)
#read subset of columns
viro <- readDFs(sumWheres, all=F, columns = c("sra","score", "pctid", "family"))

#if you are interested in specific SRAs
subset_of_sras <- c("DRR053207", "DRR053211", "DRR053215")
subset_of_sras <- paste(subset_of_sras, "fst", sep=".")
subset_of_files <- unique (grep(paste(subset_of_sras,collapse="|"), 
                        sumWheres, value=TRUE))

viro_subset <- readDFs(subset_of_files, all=F, columns = c("sra","score", "pctid", "family"))

#plot fscore histogram
familyScore(viro, "Coronaviridae", log=T)

#plot fscore/pctid histogram/scatterplot
x <- familyScorPctID(viro, "Coronaviridae")
x

#plot pctid histograms
library("grid")
p1 <- familyPctID(viro, "Coronaviridae", score_threshold = 0, title="Coronaviridae - all", x1=70, x2=100, log=T)
p2 <- familyPctID(viro, "Coronaviridae", score_threshold = 50, title="Coronaviridae - 50+", x1=70, x2=100, log=T)
p3 <- familyPctID(viro, "Coronaviridae", score_threshold = 60, title="Coronaviridae - 60+", x1=70, x2=100, log=T)
p4 <- familyPctID(viro, "Coronaviridae", score_threshold = 70, title="Coronaviridae - 70+", x1=70, x2=100, log=T)
p5 <- familyPctID(viro, "Coronaviridae", score_threshold = 80, title="Coronaviridae - 80+", x1=70, x2=100, log=T)
p6 <- familyPctID(viro, "Coronaviridae", score_threshold = 90, title="Coronaviridae - 90+", x1=70, x2=100, log=T)

grid.newpage()
grid.draw(rbind(ggplotGrob(p1),
                ggplotGrob(p2),
                ggplotGrob(p3),
                ggplotGrob(p4),
                ggplotGrob(p5),
                ggplotGrob(p6),
                size = "last"))

#plot pctid histogram with family score intervals
pctidInScoreIntervals(viro, "Coronaviridae", title="Coronaviridae")

#plot score histogram with pctid intervals
scoreInPctidIntervals(viro, "Coronaviridae", title="Coronaviridae")