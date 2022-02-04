####################
# Main script part #
####################

# Build site
blogdown::build_site(
    local = FALSE,
    build_rmd = TRUE
)

# Add .nojekyll
file.create(
    "public/.nojekyll",
    overwrite = TRUE
)