library(tidyverse)
library(httr) # for web
library(rvest) # for web
library(readxl) # for reading excel spreadsheets

# This code web scrapes oral health data from Johns Hopkin's ChildHealthData website,
# which is a platform for sharing results from the HRSA-sponsored National Survey of
# Children's Health. The first couple steps pertain to web scraping. The final steps
# pertain to tidying the data.


###########################################################################
##### Step 1: Set up lists 
###########################################################################

# Initialize empty lists to accumulate into
# The master list will contain one list of data points for every url.
# The collection list is a list of all the urls (renamed by parameters) 
# so that the code knows where to pick up again if ever paused. 
master <- list()
collection <- list()

# The 'questions' list contain the parameters that the 'for loops' below will iterate
# into our urls. Each number represents a different question-year.
questions <- c(4561, 4569, 4570, 4650, 4688, 4689,
               4700, 4835, 4905, 4906, 4907, 5012, 
               5013, 5014, 5015, 5016, 5017, 5273,
               5274, 5343, 5422, 5436, 5437, 5444,
               5497, 6465, 6466, 6535, 6606, 6607,
               6614, 6665, 6700, 6845, 6846, 6847, 
               6848, 6849, 6910, 6964, 6965, 6972, 
               7021, 7080, 7081, 7082, 7083, 7084, 
               7085, 7086, 7087, 7136, 7281, 7330, 
               7332, 7333, 7334, 7534, 7558)

# Becuase different years have different questions we prepare different 
# question lists. We use a dummy code 99999 to later represent when there 
# is no group (when we want the total counts) because then we need to 
# change the url.
groups_2016 <- c(99999, 607, 605, 606, 617, 612, 611, 613,
                 639, 615, 616, 614, 619, 620, 622, 
                 630, 628, 623, 624, 640, 625, 638)

groups_2016_2017 <- c(99999, 647, 651, 652, 653, 655, 656,
                      657, 658, 659, 662, 663, 664,
                      665, 666, 667, 668, 669, 670,
                      673, 671, 672, 674)

groups_2017 <- c(99999, 682, 686, 675, 687, 688, 689, 690,
                 691, 711, 692, 693, 694, 712, 695,
                 696, 699, 700, 701, 702, 703, 704,
                 705, 706, 708)

groups_2017_2018 <- c(99999, 715, 719, 720, 721, 723, 725,
                      726, 727, 728, 729, 730, 746,
                      731, 732, 735, 736, 737, 748,
                      738, 739, 740, 741, 742, 744)

groups_2018 <- c(99999, 752, 756, 757, 758, 760, 762, 763,
                 764, 766, 767, 768, 769, 780, 781,
                 782, 785, 771, 772, 773, 774, 776,
                 775, 777, 779) 



###########################################################################
##### Step 2: Web-scraping with a series of loops
###########################################################################

# The ChildHealthData url structure contains 3 parameters:
# r -- a number representing geographies
# q -- a number representing questions asked in different years
# g -- a number representing a stratified population group

# This code constructs every possible url permuation with an outer loop
# looping through states, middle loop looping through questions, and an 
# inner loop looping through groups.

# Geographies loop
for (r in 1:52) {
  # Question-years loop
  for (q in questions) {
    # change the group options depending on the year
    if (q < 5273) {groups <- groups_2016
    } else if (q < 6465) {groups <- groups_2016_2017
    } else if (q < 6845) {groups <- groups_2017
    } else if (q < 6964) {groups <- groups_2017_2018
    } else if (q < 7080) {groups <- groups_2018
    } else if (q < 7330) {groups <- groups_2017_2018
    } else if (q < 7559) {groups <- groups_2018}
    
    # Groups loop
    for (g in groups) {
      
      #################################################
      # Record iteration and check if previously called
      #################################################
      # Add a marker for this iteration to the collection
      # list. If already in our list, skip to the next
      # iteration. This helps if code gets restarted.
      
      combo <- paste0(r,q,g)
      
      if (combo %in% collection){next}
      
      collection[[combo]] <- combo
      
      ##################################################
      # Create the url
      ##################################################
      # We create a url with the group parameter when g is any value
      # except for 99999, otherwise we chop off that parameter.
      
      if (g == 99999) {
          url <- paste0("https://www.childhealthdata.org/browse/survey/results?q=",
                        q,
                        "&r=",
                        r)
      } else {
          url <- paste0("https://www.childhealthdata.org/browse/survey/results?q=",
                        q,
                        "&r=",
                        r,
                        "&g=",
                        g)
      }
      ##################################################
      # Retrieve the URL
      ##################################################
      # Use try functions in case there are url errors (which happen a lot).
      # If there is retrieval error it prints out the url causing the error 
      # and then waits 15 seconds before moving on. If the retrieval worked 
      # then print the successful url.
      try(remove(web_page_html))
      try(web_page_html <- read_html(url))
      if (!exists("web_page_html")) {
        print(paste0("error: ", url))
        Sys.sleep(15)
        next}
      
      print(paste0("works: ", url))
      
      #########################################
      # Subgroups
      #########################################
      # This code retrieves the names of the subgroups from 
      # the html, or assigns 'Total' if we didn't call for subgroups.
      if(g==99999) {
        compare <- c("Total")
      } else {
        compare <- html_text(
          html_nodes(
            x = web_page_html,
            css = "tbody .compare"))
      }
      
      #########################################
      # Answers
      #########################################
      # This code pulls the answer choices from the html.
      # There are certain cases where there aren't choices, which would
      # otherwise break the code so we use a next statement.
      result <- html_text(
        html_nodes(
          x = web_page_html,
          css = "thead .result"))
      
      if((length(result) - 1) < 0) {next}
      #########################################
      # Percents
      #########################################
      # We generate a matrix of rows = # subroups , cols = # answers
      percent <- html_text(
        html_nodes(
          x = web_page_html,
          css = "tbody .percent"))
      
      percent_matrix <- matrix(percent,
                               nrow = length(compare),
                               ncol = length(result),
                               byrow = TRUE)[, 1:length(result)-1, drop=FALSE]
      
      #########################################
      # Confidence Intervals
      #########################################
      # Generate a matrix as we did for percents
      CI <- html_text(
        html_nodes(
          x = web_page_html,
          css = "tbody .type_c"))
      
      CI_matrix <- matrix(CI,
                          nrow = length(compare),
                          ncol = length(result)-1,
                          byrow = TRUE)
      
      #########################################
      # Sample Counts
      #########################################
      # Generate another matrix as above
      sample <- html_text(
        html_nodes(
          x = web_page_html,
          css = "tbody .type_n"))
      
      sample_matrix <- matrix(sample,
                              nrow = length(compare),
                              ncol = length(result)-1,
                              byrow = TRUE)
      
      #########################################
      # Population Counts
      #########################################
      # Generate another matrix as above
      pop <- html_text(
        html_nodes(
          x = web_page_html,
          css = "tbody .type_w"))
      
      pop_matrix <- matrix(pop,
                           nrow = length(compare),
                           ncol = length(result)-1,
                           byrow = TRUE)
      
      #########################################
      # Loop
      #########################################
      # Create named lists where each list consists of the 
      # geography, question, answer, group, subgroup, percent
      # sample size, CI, sample size, and population count. 
      # Each of these lists will correspond to one row in a table.
      # Each list gets added to the master list, which we will later 
      # contract into a dataframe.
      
      for (element in 1:length(compare)) {
        subgroup <- compare[element]
        
        
        for (head in 1:length(result)){
          answer <- result[head]
          if(answer == "Total %") {next}
          name <- paste(q,r,g,subgroup,answer, sep="|")
          master[[name]] <- c(question = q,
                              geography = r,
                              group = g,
                              subgroup = subgroup,
                              answer = answer,
                              percent = percent_matrix[element, head],
                              CI = CI_matrix[element, head],
                              sample_size = sample_matrix[element, head],
                              population = pop_matrix[element, head])
          
        }}
      Sys.sleep(20) # seconds to wait between each url loop so we don't overload their server
    }}}

###########################################################################
##### Step 4: Save intermediate results
###########################################################################

# Most likely you won't be able to run this code in one go -- it'll take weeks. 
# So save the results to csv in between runs. Before 



# Save
save(collection, file = "collection1")
save(nsch, file = 'nsch backup')

# Convert master list to data frame and transpose
nsch <- t(as.data.frame(master))
write.csv(nsch, "nsch-june23.csv", row.names = FALSE)
write.csv(collection, "collection-jun23.csv", row.names = FALSE)


###########################################################################
##### Step 5: Load keys to decode parameters
###########################################################################

# Read in the different sheets from our excel 'key' table that helps us decode
# our parameters.

key_q <- read_excel("key.xlsx", skip = 0, sheet = "q")
key_r <- read_excel("Key.xlsx", skip = 0, sheet = "r")
key_g <- read_excel("key.xlsx", skip = 0, sheet = "g")


###########################################################################
##### Step 6: Modify the output to prepare for visualization
###########################################################################

nchs <- read.csv("nsch-june23.csv", skip = 0, na = "--") %>%
  arrange(question) %>%
  separate(CI, c("lower", "upper"), "-") %>%
  mutate(lower = as.numeric(str_trim(lower)),
         upper = as.numeric(str_trim(upper))) %>%
  mutate(width = upper - lower) %>%
  filter(width != 0) %>%
  #filter(width < 1.2*percent) %>%
  #filter(width < 20) %>%
  
  left_join(key_q, by = c("question" = "q")) %>%
  left_join(key_r, by = c("geography" = "r")) %>%
  left_join(key_g, by = c("group" = "g")) %>% 
  mutate(geo_name = ifelse(geo_name == "Nationwide", "US", geo_name),
         years = `year(s)`
        ) %>%
  select(-width, -"Possible answers", -year, -`year(s)`, -geography, -question, -label) %>%
  arrange(factor(years, levels = c("2017-2018", "2016-2017", "2018", "2017", "2016")))


###########################################################################
##### Step 7: Break the dataframe into two components: main results and confidence intervals
###########################################################################

# nchs_prime contains most of our data. Each row is a unique geography, year, question,
# answer, group, subgroup.
nchs_prime <- nchs %>%
  select(-upper, -lower)

# nchs_CI has two rows for each unique geography, year, question, answer, group, subgroup.
# One row is for the upper confidence interval, one for the lower. We also add a column 
# representing the 'order' of the vertexes we will need for drawing polygons in Tableau.
# For lower confidence intervals the order counts up; for upper confidence intervals they
# count down. We choose a very large upper bound so that there is a large middle of available
# orders if additional data gets added in the next year.

nchs_CI <- nchs %>%
  select(-population, -percent, -sample_size, -"Question long") %>%
  pivot_longer(cols=c("lower", "upper"), values_to = "confidence_value", names_to = "confidence_level") %>%
  mutate(order = ifelse(confidence_level == "lower", 1:n(), 1000000000 - 1:n()))


###########################################################################
##### Step 8: Save final output to csv
###########################################################################

write.csv(nchs_prime, "nchs_prime.csv", row.names = FALSE, na = "")
write.csv(nchs_CI, "nchs_CI.csv", row.names = FALSE, na = "")