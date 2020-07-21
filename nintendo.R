library(rvest)
library(DT)

# webpage to scrape
url_nintendo <- "https://www.bestbuy.com/site/searchpage.jsp?_dyncharset=UTF-8&browsedCategory=pcmcat1484080052161&id=pcat17071&iht=n&ks=960&list=y&qp=customerreviews_facet%3DCustomer%20Rating~Top-Rated&sc=Global&st=categoryid%24pcmcat1484080052161&type=page&usc=All%20Categories"

# Read it into R
webpage <- read_html(url_nintendo)

## Parse the listing of games ----
games <- html_nodes(webpage, '.sku-header a')

# Get the names
game_titles <- html_text(games)

# Get the URLs for detailed pages
webpage_relative <- html_attr(games, "href")

# Add the main website to compose the full URL
full_links <- paste0("https://www.bestbuy.com", webpage_relative)

## Get the users' ratings listing ----
ratings <- html_nodes(webpage, '.c-stars-v3')

# Get the score
ratings_score <- html_attr(ratings, "alt") %>%
  as.numeric()

## Combine all of these into a data frame ----
df_switch_games <- data.frame(game = game_titles,
                          website = full_links,
                          ratings = ratings_score)

# Render the table
DT::datatable(df_switch_games)
