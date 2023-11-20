# Cyclistic Sharing-Bike Analysis

![Static Badge](https://img.shields.io/badge/R-Big_Data-blue)
![Static Badge](https://img.shields.io/badge/kaggle-Jupyter_Notebook-yellow)
![Static Badge](https://img.shields.io/badge/Google-Analytics_Certificate-red)  

<img src="/img/citybike.png"  width="300">

## Background

- A Google Data Analytics Professional Certificate case study.

- Real-world data + fictional company (Cyclistic)

- Task: analyze data, answer critical business questions, and make data-driven recommendations to maximize annual memberships.

- Business Objective: Chicago bike-sharing company Cyclistic aimed to increase annual memberships based on understanding the differences in bike usage between annual members and casual riders.

- Key Questions: 
  - How do annual members and casual riders use Cyclistic bikes differently?
  - Why would casual riders buy Cyclistic annual memberships?
  - How can Cyclistic use digital media to influence casual riders to become members?

## Data

| Data Overview       | Value          |
|---------------------|----------------|
| Data size           | 3.3G           |
| Number of files     | 41             |
| Number of columns   | 13             |
| Number of rows      | 17,962,572     |

## Feature

### Created reusable R modules to handle general situations.

```r
comparable_summaries(df, col, groups)
# A comprehensive function build on skim() to display summaries in concise and comparable way.
# Functioning early findings in comparable scenarios.
```

```r
check_column_consistenc(csv_files, std_cols)
# Check if the cols of multiple csv files are consistent.
```

```r
combine_csvs_to_tibble(csv_files)
# Merge csvs into one tibble
```

```r
convert_datetime(column) 
# Convert messey POSIXct formats to uniform datetime
```

```r
convert_datetime(column) 
# Convert messey POSIXct formats to uniform datetime
```

```r
empty_value_monthly(tb, date_col, col1, col2)
# Display distribution of empty value in cols with bar chart
```

### Graphical Analysis

The project used graphical libraries to gain insights (see below).

## Processes

- Ask: Defined key business questions and objectives.
- Prepare: Gathered and cleaned the data from various sources.
- Process: Performed data manipulation and transformation for analysis.
- Analyze: Conducted in-depth analysis to uncover insights.
- Share: Communicated findings through visualizations and reports.
- Act: Presented recommendations based on data insights.

## Key Findings

### Initial findings from ```comparable_summaries(df, col, groups)```

![Alt compare1](/img/image.png)

- Casual riders are over 40%, showing high business potential.
- Although the distance of trips are similar, casual trips are 2.44 times slower in speed. Which shows evidence of leisure riding.

![Alt compare2](/img/image-1.png)

- The popular stations for two groups are distinct.

![Alt compare3](/img/image-2.png)

- For casual, more riding happened on weekends.

### Insights from graphical analysis

![Alt map1](/img/image-3.png)

- Member's station distributed in clusters. 
- Casual user's stations are along the lake.

![Alt map2](/img/image-4.png)

- Top stations in Weekend and weekdays are distinct.
- Casual riders are significantly more active in weekend. 

![Alt map2](/img/image-6.png)

- Further investigation: The most popular stations are located in the most popular city attractions

### Findings of travel time patterns

![Alt seasonal](/img/image-7.png)

- Strong seasonal volatility.
- Both trips are at the same level in Summer.
- Casual trips drop to significant lower level in winter.

![Alt weektime](/img/image-8.png)

- Trends are very similar in weekdays or in weekends respectively.
- In weekend, Overlapping lines reveal same behavior between two groups.
- In weekdays, the riding time is distinct.
- The peaks appear around 15 pm in weekends, and 17 pm in weekdays.
- No peak in weekday mornings for casual riding. But small peaks appear in evening rush hours.

### Summary of Findings

- Casual riders still make up a large percentage
  - More than 40% ridings are made by casual riders.
  - The portation of casual are stable and the number are slightly growing in the last 3 years.
- Casual riders show clear evidence to perform leisure tourism.
  - They ride the similar distance in much longer time.
  - Their favorite stations spread along the beach.
  - They strongly prefer riding in Weekend, and have the same time pattern with members.
  - On weekday, they tend to ride around evening rush hours.
  - Their number of rides is at the same or even higher level in Summer. But in winter, they ride much less.

## Patterns and Strategies

| PATTEN               | STRETAGY             |
|---------------------|----------------------|
| Inactive Winter     | Introduce Monthly Membership |
| Slow riding         | Gifting free distance rather than free time |
| Popular stations    | Conducting promotions at top stations  |
| Favorite time       | Rebates for weekends and evening peak |
| Purpose of leisure  | Relaxing online and offline campaigns  |

## Key Tools

- R
  - RStudio
  - R Markdown
- SpreadSheet
- Kaggle
  - Kaggle Notebook
- Git
  - GitHub Repository
