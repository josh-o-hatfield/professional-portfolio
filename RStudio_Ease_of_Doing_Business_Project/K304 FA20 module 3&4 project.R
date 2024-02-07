# If completing this assignment as a team,
# make sure I have set up your team in Canvas (or it won't be able to award all team members credit).
# Additionally, please list team members' names
# and usernames on the lines just below:
# 1. 
# 2. 
# 3. 

# Run the three lines of code below to install the packages needed. ####
# As always, installing the Tidyverse packages will take a few minutes.
# ggthemes and ggrepel should go much faster.

install.packages("tidyverse")
install.packages("ggthemes")
install.packages("ggrepel")

# Once installation completes, find: ####
# dplyr (*not* dbplyr),
# ggplot2,
# ggthemes, and
# ggrepel
# in the Packages list, and check their boxes.

# Import the necessary data by running the line of code below. ####
DoingBusiness <- read.csv("https://iu.box.com/shared/static/fv0l9h35p76qzqiocnxe9ju8pcige1cw.csv")

# FOR EACH PROBLEM, LOCATE *ALL* WORK FOR THAT PROBLEM JUST BELOW ITS PROMPT.

# Do not make any modifications to the Doing Business object,
# since you will submit only your R script file. We will run your code on *our* imported dataset.

# Part 1 ####

# *Here and elsewhere on this project*, you may need to filter
# or otherwise structure the data before creating a plot.
# When you do this, write your code in the area designated for that problem,
# assign results to a variable, naming the variable as indicated.

# Problem 1. Days to start a business, African subregions, 2004 versus 2018. ####
# See the sketch for plot 1.
# Color-code the outlines, but not the interiors, of the boxes.

# First, create the data source for the chart.
# Name the data source plot_1_data

plot_1_data <- DoingBusiness %>% 
  filter(WorldRegion == "Africa", SurveyYear == 2004 | SurveyYear == 2018) %>% 
  group_by(SubRegion)

# Then, create the chart.

ggplot(plot_1_data, aes(x = SubRegion, y = StartBus.Days, color = SubRegion)) +
  geom_boxplot(show.legend = FALSE) +
  scale_color_brewer(palette = "Accent") +
  facet_wrap(~SurveyYear) +
  ggtitle("Plot 1: Days to start a business, Africa, 2004 vs. 2018") +
  labs(x = "Subregion", y = "Days to start a business") +
  theme(axis.text.x = element_text(angle = 90))

#***I removed the legend for the plot above since the plot image did not show a legend,
#even though the note did not indicate to do so.

# Part 2. OECD: 2018 makeup by region; growth in membership over time. ####
# OECD: Organisation for Economic Cooperation and Development

# Problem 2.1 Percent makeup of OECD countries by region, 2018 data. ####
# See the sketch for table 1.
# Store results as a variable named table_1

table_1 <- DoingBusiness %>% 
  filter(SurveyYear == 2018) %>% 
  group_by(WorldRegion) %>% 
  summarize(Total = sum(OECDMember)) %>% 
  mutate(Pct = Total / sum(Total) * 100)

# Problem 2.2 Growth in OECD membership over time, by region, ####
# limited to regions with OECD members.
# See the sketch for table 2.
# Store results as a variable named table_2

table_2 <- DoingBusiness %>% 
  filter(OECDMember == 1) %>% 
  group_by(SurveyYear, WorldRegion) %>% 
  summarize(Total = n())

# Problem 2.3 Graph the table_2 results. ####
# See the sketch for plot 2.

ggplot(table_2, aes(x = SurveyYear, y = Total, color = WorldRegion)) +
  geom_line() +
  ggtitle("Plot 2: Total OECD members by region") +
  labs(x = "DB survey year", y = "OECD members") +
  theme_tufte()

# Part 3. Starting a business vs. enforcing contracts, OECD (and non-OECD). ####

# Problem 3.1 Days to start a business versus days to enforce a contract, ####
# OECD countries only,
# in 2004 and 2018.
# See the sketch for plot 3.
# Name the data source plot_3_data

plot_3_data <- DoingBusiness %>% 
  filter(OECDMember == 1, SurveyYear == 2004 | SurveyYear == 2018)

ggplot(plot_3_data, aes(x = StartBus.Days, y = EnforceContract.Days, color = SubRegion)) +
  geom_point(show.legend = FALSE) +
  facet_wrap(~SurveyYear) +
  geom_text_repel(aes(label = EconomyName)) +
  ggtitle("Plot 3: Enforcing a contract vs. starting a business, OECD countries, 2004 vs. 2018") +
  labs(x = "Days to start a business", y = "Days to enforce a contract") +
  theme_tufte() +
  theme(legend.position = "none")

# Problem 3.2 Days to enforce contracts in OECD countries, by economy and year ####
# Look over plot 3 to identify four countries that showed a lot of movement from 2004 to 2018
# in the "days to enforce" dimension, and plot only those.
# See the sketch for plot 4.
# Name the data source plot_4_data

plot_4_data <- DoingBusiness %>% 
  filter(EconomyName %in% c("Greece", "Italy", "Finland", "Canada")) %>% 
  group_by(EconomyName, SurveyYear)

ggplot(plot_4_data, aes(x = SurveyYear, y = EnforceContract.Days)) +
  geom_line() +
  facet_wrap(~EconomyName) +
  ggtitle("Plot 4: Days to enforce contracts, select OECD countries") +
  theme_fivethirtyeight() +
  theme(plot.title = element_text(size = 12))

# Problem 3.3 Days to start a business, non-OECD and OECD countries, 2004 and 2018 ####
# See the sketch for plot 5.
# !!! Note: To use OECD membership as the x, you will need to make it a factor.
# In your ggplot code, rather than x = OECDMember, use x = factor(OECDMember)
# Name the data source plot_5_data

plot_5_data <- DoingBusiness %>% 
  filter(SurveyYear == 2004 | SurveyYear == 2018)
  
ggplot(plot_5_data, aes(x = factor(OECDMember), y = StartBus.Days, fill = WorldRegion)) +
  geom_boxplot(show.legend = FALSE) +
  facet_grid(SurveyYear~WorldRegion) +
  ggtitle("Plot 5: Days to start a business, non-OECD vs. OECD, 2004 vs. 2018") +
  labs(x = "1 = OECD", y = "Days to start a business") +
  theme_gdocs() +
  theme(plot.title = element_text(size = 12))

# Part 4. Key starting efficiency measures: Select EU economies, all-Europe, world regions. ####

# Problem 4.1 Belgium, France, Germany, Ireland, Luxembourg, and Netherlands are countries that have become/are expected
# to become the home of new headquarters and other operations for a number of companies planning to leave the UK post-Brexit.
# Look at combined days to start a business and obtain electricity in those six countries, over the years of the Doing Business study.
# Since the Doing Business study did not contain the "Elec.Days" question prior to 2010,
# only years from 2010 and after should be included.
# See the sketch for plot 6.
# Name the data source plot_6_data

plot_6_data <- DoingBusiness %>% 
  filter(SurveyYear >= 2010, EconomyName %in% c("Belgium", "France", "Germany", "Ireland", "Luxembourg", "Netherlands")) %>% 
  group_by(EconomyName, SurveyYear) %>% 
  summarize(Days = Electricity.Days + StartBus.Days)

ggplot(plot_6_data, aes(x = SurveyYear, y = Days, color = EconomyName)) +
  geom_line() +
  scale_color_brewer(palette = "Dark2") +
  ggtitle("Plot 6: Days to start a business and get electricity, 2010-present") +
  labs(x = "DB survey year", y = "Days to start and get electricity") +
  theme_tufte()

# Problem 4.2 Days that it has taken to start a business and obtain electricity over the years,
# in Europe. ####
# Only the years 2010 and after should be included, for the reason given in the previous problem.
# See the sketch for plot 7.
# Name the data source plot_7_data

plot_7_data <- DoingBusiness %>% 
  filter(SurveyYear >= 2010, WorldRegion == "Europe") %>% 
  group_by(EconomyName, SurveyYear, IncomeGroup) %>% 
  summarize(Days = Electricity.Days + StartBus.Days)

ggplot(plot_7_data, aes(x = SurveyYear, y = Days, color = IncomeGroup)) +
  geom_line() +
  facet_wrap(~EconomyName) +
  scale_color_brewer(palette = "Dark2") +
  ggtitle("Plot 7: Days to start a business and get electricity, 2010-present") +
  labs(x = "DB survey year", y = "Days, start and get electricity") +
  theme_tufte() +
  theme(axis.text.x = element_blank(), 
        axis.ticks.x = element_blank())

# Problem 4.3 Number of records, P25, P50, and P75 of combined days to start a business + obtain a building permit, ####
# by region, year, and OECD status.
# See the sketch for table 3.
# Store results as a variable named table_3

table_3 <-DoingBusiness %>% 
  filter(SurveyYear >= 2006) %>% 
  group_by(WorldRegion, SurveyYear, OECDMember) %>% 
  mutate(Days = StartBus.Days + BldgPermits.Days) %>% 
  summarize(Countries = n(), 
            P25StartandConstr = quantile(Days, 0.25, na.rm = TRUE), 
            P50StartandConstr = quantile(Days, 0.50, na.rm = TRUE), 
            P75StartandConstr = quantile(Days, 0.75, na.rm = TRUE))

# Problem 4.4 Graph the P75 values from table 3 so that within each region we can explore ####
# progress in this downside measure over the years.
# See the sketch for plot 8.

ggplot(table_3, aes(x = SurveyYear, y = P75StartandConstr, color = WorldRegion)) +
  geom_line() +
  facet_wrap(~OECDMember) +
  ggtitle("Plot 8: P75 of days to start a business and obtain construction permits, 2006-present, non-OECD vs. OECD") +
  labs(x = "DB survey year", y = "Days, start and constr permits") +
  theme_economist() +
  theme(plot.title = element_text(size = 12))