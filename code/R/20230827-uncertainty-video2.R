library(cowplot)
library(av)
library(ggplot2)
library(ggpubr)
dbetabinom <- function(x,n,alpha,beta) {choose(n, x)*beta(alpha+x,beta+n-x)/beta(alpha,beta)}
num_frames <- 100  # Number of frames in the video
k_param <- seq(1, 20, length.out = num_frames)  # Varying parameter for Beta distribution
u <- 3
v <- 10
frames_folder <- "video_frames/"
dir.create(frames_folder, showWarnings = FALSE)

for (i in 1:num_frames) {
  # Generate data for the distributions
  x <- 0:20
  t <- seq(0, 1, 0.005)
  p <- u / (u + v * k_param[i])
  binomial_pdf <- dbinom(x, size = 20, prob = p)
  betabinomial_pdf <- dbetabinom(x, 20, u, v * k_param[i])
  beta_pdf <- dbeta(t, shape1 = u, shape2 = v * k_param[i])
  df <- data.frame(x = rep(x, 2), pdf = c(binomial_pdf, betabinomial_pdf),distribution = rep(c("Binomial", "Beta-binomial"), each = length(x)))
  # Create plots
  plot1 <- ggplot(df, aes(x, pdf, fill=distribution)) + geom_bar(stat="identity", position="dodge", width = 0.9) + labs(title = "Binomial vs. Beta-binomial", x="x", y="pdf")+scale_fill_manual(values = c("Binomial" = "orchid", "Beta-binomial" = "skyblue"))+theme_pubr()
  
  plot2 <- ggplot() +
    geom_line(aes(x = t, y = beta_pdf), color = "orchid", size=1.8) +
    labs(title = "Beta Distribution", x="x", y="")+theme_pubr()+annotate("text", x = 0.5, y = max(beta_pdf) *2/3, label = sprintf("alpha:%.2f\n beta:%.2f", u, v*k_param[i]), color = "black", size = 4)
  
  # Arrange plots horizontally
  combined_plot <- plot_grid(plot1, plot2, labels = "AUTO")
  
  # Save the combined plot as an image
  plot_filename <- paste0(frames_folder, "frame_", sprintf("%03d", i), ".png")
  ggsave(plot_filename, combined_plot, width = 12, height = 6)
}
frames <- list.files(frames_folder, pattern = "frame_.*\\.png", full.names = TRUE)
output_video <- "comparison_video_beta.mp4"

av::av_encode_video(frames, output_video, framerate = 10)
utils::browseURL(output_video)

unlink(frames)


