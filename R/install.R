########################
# Install setup script #
########################

# Install packages
## Blogdown
install.packages("blogdown")
## PDF render
install.packages("magick")
install.packages("pdftools")

# Install Hugo
blogdown::install_hugo(
    version = "0.87.0"
)