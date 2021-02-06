#
wd <- '\\\\bki05\\n$\\bgcode2\\matlab\\SegTool\\QC'
images <- c('1','2','3','4', '5','6')
my.graph.d <- data.frame()
for (i1 in images){
  #
  tbl <- data.table::fread(paste0(wd,'\\image_',i1,'_dice.csv'))
  my.cols <- colnames(tbl)
  my.cols <- my.cols[3:length(my.cols)]
  #
  for (i2 in my.cols){
    #  
    my.d <- dplyr::select(tbl, tidyselect::all_of(`i2`))
    my.d[which(my.d[[`i2`]] > 1), 1] = 1
    my.d <- my.d[which(my.d[[`i2`]] != 0)]
    colnames(my.d) <- c('dat')
    my.d <- dplyr::mutate(my.d, j_dat = (dat / (2-dat)))
    my.d <- dplyr::summarise(my.d, s_m = 100*mean(dat),
                             s_sd_u = mean(dat) + sd(dat),
                             s_sd_l = mean(dat) - sd(dat), 
                             j_m = 100*mean(j_dat),
                             j_sd_u = mean(j_dat) + sd(j_dat),
                             j_sd_l = mean(j_dat) - sd(j_dat))
    val <- substring(`i2`, 4)
    my.d <- dplyr::mutate(my.d, type = val, image = `i1`)
    #
    my.graph.d <- rbind(my.graph.d, my.d)
    #
  }
}
#
tit.size = 20
#
p <-ggplot2::ggplot(
  my.graph.d, ggplot2::aes(
    x = type, y = s_m, color = image, fill = image
    )
  ) + ggplot2::labs(x = 'Annotator Pairs', y = 'DSC \n(%, mean over cells)',
                    title = 'Sorensen-Dice Similarity Coefficient (DSC) \nby Annotator Pairs',
                    color = 'Image') +
  ggplot2::scale_y_continuous(breaks= seq(50,100,10), limits = c(50,100))+
  ggplot2::scale_color_manual(values = colors) + 
  ggplot2::guides(color=ggplot2::guide_legend(ncol=2), fill = F)+
  ggplot2::geom_point(size = 2.5) + theme1 + ggplot2::theme(
    aspect.ratio = 1,
    panel.grid.major.y = ggplot2::element_blank(),
    panel.grid.major.x = ggplot2::element_blank(),
    panel.grid.minor.y = ggplot2::element_blank(),
    panel.grid.minor.x = ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),
    text = ggplot2::element_text(size = 10),
    panel.border = ggplot2::element_rect(
      size=.5, color='black',fill=NA),
    axis.line = ggplot2::element_blank(),
    axis.title.x = ggplot2::element_text(vjust = 0, size = tit.size - 2),
    axis.title.y = ggplot2::element_text(vjust = 0, size = tit.size - 2),
    plot.title = ggplot2::element_text(hjust = 0.5, size = tit.size),
    legend.text.align = 2,
    legend.text = ggplot2::element_text(size = tit.size - 4),
    legend.background = ggplot2::element_blank(),
    legend.key.size = ggplot2::unit(.2,'in'),
    legend.title = ggplot2::element_text(size = tit.size - 2),
    plot.margin = ggplot2::margin(
      t = 8, r = 10, b = 8, l = 10, unit = "pt"),
    legend.position = c(.15,.4),
    axis.text.x = ggplot2::element_text(size = tit.size - 6),
    axis.text.y = ggplot2::element_text(size = tit.size - 6),
    axis.ticks.x = ggplot2::element_line())
#
ggplot2::ggsave(file="test.png", plot=p)
#
ggplot2::ggplot(
  my.graph.d, ggplot2::aes(
    x = type, y = j_m, color = image
  )
) + ggplot2::labs(x = 'Annotator Pairs', y = 'AJI \n(%, mean over cells)',
                  title = 'Aggregate Jaccard Index (AJI) \n by Annotator Pairs',
                  color = 'Image') +
  ggplot2::scale_y_continuous(breaks= seq(50,110,10), limits = c(50,110))+
  ggplot2::scale_color_manual(values = colors) + 
  ggplot2::guides(color=ggplot2::guide_legend(ncol=2
  ggplot2::geom_point() + theme1 + ggplot2::theme(
    aspect.ratio = 1,
    panel.grid.major.y = ggplot2::element_blank(),
    panel.grid.major.x = ggplot2::element_blank(),
    panel.grid.minor.y = ggplot2::element_blank(),
    panel.grid.minor.x = ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),
    text = ggplot2::element_text(size = 10),
    panel.border = ggplot2::element_rect(
      size=.5, color='black',fill=NA),
    axis.line = ggplot2::element_blank(),
    axis.title.x = ggplot2::element_text(vjust = 0, size = 10),
    axis.title.y = ggplot2::element_text(vjust = 0, size = 10),
    plot.title = ggplot2::element_text(hjust = 0.5, size = 12),
    legend.text.align = 1,
    legend.background = ggplot2::element_blank(),
    legend.key.size = ggplot2::unit(.1,'in'),
    legend.title = ggplot2::element_text(size = 10),
    plot.margin = ggplot2::margin(
      t = 8, r = 10, b = 8, l = 10, unit = "pt"),
    legend.position = c(.89,.87),
    axis.text.x = ggplot2::element_text(),
    axis.ticks.x = ggplot2::element_line())