####################
# Main script part #
####################

# Build site
blogdown::build_site(
    local = FALSE
)

# Add .nojekyll
file.create(
    "public/.nojekyll",
    overwrite = TRUE
)