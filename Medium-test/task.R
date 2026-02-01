required_pkg <- c("tidyr", "glmmTMB", "lme4", "ggplot2","readr","dplyr","knitr","rlang")

for(pkg in required_pkg) {
  if(!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

data_file <- "air.csv"


air_pollution_analysis <- function(data_path = "Medium-test/air.csv", output_dir = "/workspaces/rstats-gsoc2026-task--glmmTMB-via-RTMB-/Medium-test/result"){

    results <- list() 
    results$output_dir <- output_dir
    results$data_clean <- filter_data(data_path,output_dir)
    results$eda_results <- eda(results$data_clean,output_dir)
    visualizations(results$data_clean,output_dir)
    results$model_data <- model_data(results$data_clean,output_dir)
    results$models <- fit_models(results$model_data,output_dir)
    results$model_comparsion   <- compare_models(results$models,output_dir)
    

}

filter_data <- function(data_path="Medium-test/air.csv", output_dir){

    air_data <- read_csv(data_path)

    air_clean <- air_data |>
                    select("State","State-County","POLLUTANT","Emissions (Tons)",
                          "SCC LEVEL 1","SCC LEVEL 2","SCC LEVEL 3","SCC LEVEL 4")|>
                          rename(
                            state = "State", 
                            pollutant = "POLLUTANT" , 
                            emissions = "Emissions (Tons)", 
                            county = "State-County", 
                            level_1 = "SCC LEVEL 1", 
                            level_2 = "SCC LEVEL 2", 
                            level_3 = "SCC LEVEL 3", 
                            level_4 = "SCC LEVEL 4"
                          ) |>
                          mutate(
                            emissions = as.character(emissions), 
                            emissions = parse_number(emissions), 
                            emissions = replace_na(emissions),
                            emissions = as.numeric(emissions)
                          ) |>
                          filter(!is.na(emissions))
                          writeLines(kable(as.data.frame(air_clean,format = "html")), "Medium-test/result/clean_data.html")
                          return(air_clean)
}

eda <- function(data,output_dir){
    results <- list()

    results$overall <- data |>
        summarise(
      total_observations = n(),
      unique_states = n_distinct(state),
      unique_counties = n_distinct(county),
      unique_pollutants = n_distinct(pollutant),
      total_emissions = sum(emissions),
      mean_emissions = mean(emissions),
      median_emissions = median(emissions),
      sd_emissions = sd(emissions)
    )

    results$pollutants <-  data |>
            group_by(pollutant) |>
                  summarise(
                  total_emissions = sum(emissions),
                  mean_emissions = mean(emissions),
                  count = n(),
                  .groups = "drop"
                            )  |>
            arrange(desc(total_emissions))

    results$states <- data  |>
            group_by(state) |>
                summarise(
                total_emissions = sum(emissions),
                mean_emissions = mean(emissions),
                count = n(),
                .groups = "drop"
                          ) |>
            arrange(desc(total_emissions))

  writeLines(kable(as.data.frame(results$overall,format = "html")), "Medium-test/result/overall_stats.html")

  writeLines(kable(as.data.frame(results$pollutants,format = "html")), "Medium-test/result/pollutant_stats.html")

  writeLines(kable(as.data.frame(results$states,format = "html")), "Medium-test/result/state_stats.html")


  return(results)


}


visualizations <- function(data,  output_dir) {
  
  # 1. Pollutant Emissions by County (Faceted Bar Plot)
  region_pollutant <- data %>%
    group_by(state, county, pollutant) %>%
    summarise(total_emissions = sum(emissions, na.rm = TRUE), .groups = "drop")
  
  p1 <- ggplot(region_pollutant, aes(x = pollutant, y = total_emissions, fill = pollutant)) +
    geom_bar(stat = "identity", alpha = 0.8) +
    facet_wrap(~ county, scales = "free_y") +
    labs(title = "Pollutant Emissions by County",
         x = "Pollutant", y = "Total Emissions (Tons)", fill = "Pollutant") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  ggsave(file.path(output_dir, "pollutant_emissions_by_county.png"), 
         plot = p1, width = 12, height = 8, dpi = 300)
  
  
  # 2. Pollutant Breakdown by State–County (Grouped Bar Plot)
  state_pollutant <- data %>%
    group_by(state, county, pollutant) %>%
    summarise(total_emissions = sum(emissions, na.rm = TRUE), .groups = "drop")
  
  p2 <- ggplot(state_pollutant, aes(x = interaction(state, county), 
                                    y = total_emissions, fill = pollutant)) +
    geom_bar(stat = "identity", position = "dodge", alpha = 0.8) +
    coord_flip() +
    labs(title = "Pollutant Breakdown by State–County",
         x = "State–County", y = "Total Emissions (Tons)", fill = "Pollutant") +
    theme_minimal()
  
  ggsave(file.path(output_dir, "pollutant_breakdown_by_state_county.png"), 
         plot = p2, width = 12, height = 8, dpi = 300)
  
}



# Prepare modeling data
model_data <- function(data, output_dir){
  model_data <- data |>
    group_by(pollutant) |>
    filter(n() > 50) |>   # keep pollutants with enough observations
    ungroup() |>
    mutate(
      county_id = sub("^.*- ", "", county),
      county_id = factor(county_id),
      log_emissions = log10(emissions + 1),
      source_type = case_when(
        grepl("Diesel", `level_2`, ignore.case = TRUE) ~ "Diesel",
        TRUE ~ "Non-Diesel"
      ),
      source_type = factor(source_type),
      region = case_when(
        state %in% c("California", "Oregon", "Washington") ~ "West",
        state %in% c("Texas", "Florida", "Georgia") ~ "South",
        state %in% c("New York", "Pennsylvania", "New Jersey") ~ "Northeast",
        state %in% c("Illinois", "Ohio", "Michigan") ~ "Midwest",
        TRUE ~ "Other"
      ),
      region = factor(region)
    ) |>
    filter(emissions <= quantile(emissions, 0.99, na.rm = TRUE))  # remove extreme outliers
  
   writeLines(kable(as.data.frame(model_data,format = "html")), "Medium-test/result/modeling_data.html")

  return(model_data)
}

# Fitting the data prepared (by: model_data() funct'n)
# Model Used : lme4 & glmmTMB 
fit_models <- function(model_data, output_dir){
  models <- list()
  
  # Question 1: Which pollutants have systematically higher emissions across counties?
  models$lme4_q1 <- lmer(log_emissions ~ pollutant + (1 | county_id), data = model_data)
  models$glmmTMB_q1 <- glmmTMB(log_emissions ~ pollutant + (1 | county_id), 
                               data = model_data, family = gaussian())
  
  # Question 2: How much variation in emissions is due to county vs pollutant type ?
  models$lme4_q3 <- lmer(log_emissions ~ pollutant + (1 | county_id), data = model_data)
  models$glmmTMB_q3 <- glmmTMB(log_emissions ~ pollutant + (1 | county_id), 
                               data = model_data, family = gaussian())
  
  # Question 3: Are diesel sources consistently higher emitters than non‑diesel sources?
  models$lme4_q4 <- lmer(log_emissions ~ pollutant + source_type + (1 | county_id), data = model_data)
  models$glmmTMB_q4 <- glmmTMB(log_emissions ~ pollutant + source_type + (1 | county_id), 
                               data = model_data, family = gaussian())
  
  file_paths <- paste0("Medium-test/result/", names(models), "_summary.html")
  lapply(seq_along(models), function(i){    
    summary_text <- capture.output(summary(models[[i]]))
    summary_df <- as.data.frame(summary_text,format = "html")
    html_table <- kable(summary_df)
    writeLines(html_table,file_paths[i])
  } )
  
  return(models)
} 

# Comparsion different model results quality,  used to answer the question's up there : 
compare_models <- function(models, output_dir){
  comparison_data <- data.frame()
  
  for (model_name in names(models)) {
    model <- models[[model_name]]
    if (!is.null(model)) {
      comparison_data <- rbind(comparison_data, data.frame(
        Model = model_name,
        AIC = AIC(model),
        BIC = BIC(model),
        LogLik = as.numeric(logLik(model)),
        stringsAsFactors = FALSE
      ))
    }
  }
  
  writeLines(kable(as.data.frame(comparison_data,format = "html")), "Medium-test/result/model_comparsion.html")

  return(comparison_data)
}



results <- air_pollution_analysis()