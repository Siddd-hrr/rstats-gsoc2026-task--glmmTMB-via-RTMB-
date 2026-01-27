required_pkg <- c("tidyr", "glmmTMB", "lme4", "ggplot2","readr","dplyr")

for(pkg in required_pkg) {
  if(!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

data_file <- "air.csv"


air_pollution_analysis <- function(data_path = "Medium-test/air.csv", output_dir = "/workspaces/rstats-gsoc2026-task--glmmTMB-via-RTMB-/Medium-test/output_dir"){

    results <- list() 
    results$output_dir <- output_dir
    results$data_clean <- filter_data(data_path,output_dir)
    results$eda_results <- eda(results$data_clean,output_dir)
    visualizations(results$data_clean,results$eda,output_dir)
    # results$model_data <- modeling(results$data_clean,output_dir)
    # results$models <- models(results$models,output_dir)
    # results$model_comparsion   <- compare_models(results$models,output_dir)
    # diagnostics(results$models,output_dir)
    # gen_report(results$eda_results,results$model_comparsion,output_dir)


}

filter_data <- function(data_path="Medium-test/air.csv", output_dir = "/workspaces/rstats-gsoc2026-task--glmmTMB-via-RTMB-/Medium-test/output_dir"){

    air_data <- read_csv(data_path)

    air_clean <- air_data |>
                    select("State","State-County",POLLUTANT,"Emissions (Tons)",
                          "SCC LEVEL 1","SCC LEVEL 2","SCC LEVEL 3","SCC LEVEL 4")|>
                          rename(
                            state = "State", 
                            pollutant = POLLUTANT , 
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
                          write_csv(air_clean, file.path(output_dir,"clean_data.csv"))
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

    results$pollutants <- data |>
    group_by(pollutant) |>
    summarise(
      total_emissions = sum(emissions),
      mean_emissions = mean(emissions),
      count = n(),
      .groups = "drop"
    ) |>
    arrange(desc(total_emissions))

     results$states <- data |>
    group_by(state) |>
    summarise(
      total_emissions = sum(emissions),
      mean_emissions = mean(emissions),
      count = n(),
      .groups = "drop"
    ) |>
    arrange(desc(total_emissions))

  write_csv(results$overall, file.path(output_dir, "overall_stats.csv"))
  write_csv(results$pollutants, file.path(output_dir, "pollutant_stats.csv"))
  write_csv(results$states, file.path(output_dir, "state_stats.csv"))

    return(results)


}

visualizations <- function(data, eda_results,output_dir){

  p1 <- ggplot(data, aes(x = log(emissions + 1))) + 
          geom_histogram(fill = "steelblue" , bins = 50 , alpha = 0.7) + 
          labs(title = "Distribution of Emission", 
                x = "log10(Emissions + 1)", y = "Count") + 
                theme_minimal() 
          
          ggsave(file.path(output_dir , "emissions_distribution.png"), plot = p1 , width = 10, height  = 7 , dpi = 300 )
  
  top-10-pollutants <- head(eda_results$pollutants,10)
  p2 <- ggplot(top-10-pollutants, 
               aes(x = reorder(pollutant, total_emissions), 
                   y = total_emissions)) +
    geom_bar(stat = "identity", fill = "darkgreen", alpha = 0.7) +
    coord_flip() +
    labs(title = "Top 10 Pollutants by Total Emissions", 
         x = "Pollutant", y = "Total Emissions (Tons)") +
    theme_minimal()
  
  ggsave(file.path(output_dir, "top_pollutants.png"), 
         plot = p2, width = 10, height = 7, dpi = 300)
  
  
  top-10-states <- head(eda_results$states, 10)
  p3 <- ggplot(top-10-states, 
               aes(x = reorder(state, total_emissions), 
                   y = total_emissions)) +
    geom_bar(stat = "identity", fill = "darkred", alpha = 0.7) +
    coord_flip() +
    labs(title = "Top 10 States by Total Emissions", 
         x = "State", y = "Total Emissions (Tons)") +
    theme_minimal()
  
  ggsave(file.path(output_dir, "top_states.png"), 
         plot = p3, width = 10, height = 7, dpi = 300)


}



results <- air_pollution_analysis()