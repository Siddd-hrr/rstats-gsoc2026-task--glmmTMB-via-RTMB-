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

  write_csv(results$overall, file.path(output_dir, "overall_stats.csv"))
  write_csv(results$pollutants, file.path(output_dir, "pollutant_stats.csv"))
  write_csv(results$states, file.path(output_dir, "state_stats.csv"))

  return(results)


}

visualizations <- function(data, eda_results,output_dir){

  p1 <- ggplot(data, aes(x = log(emissions + 1))) + 
        geom_histogram(fill = "steelblue" , bins = 50 , alpha = 0.7) + 
        labs(title = "Distribution of Emission", x = "log10(Emissions + 1)", y = "Count") +  theme_minimal() 
  ggsave(file.path(output_dir , "emissions_distribution.png"), plot = p1 , width = 10, height  = 7 , dpi = 300 )
  
  top_10_pollutants <- head(eda_results$pollutants,10)
  p2 <- ggplot(top_10_pollutants, aes(x = reorder(pollutant, total_emissions), y = total_emissions)) +
        geom_bar(stat = "identity", fill = "darkgreen", alpha = 0.7) + coord_flip() + labs(title = "Top 10 Pollutants by Total Emissions",  x = "Pollutant", y = "Total Emissions (Tons)") + theme_minimal()
  ggsave(file.path(output_dir, "top_pollutants.png"), plot = p2, width = 10, height = 7, dpi = 300)
  
  
  top_10_states <- head(eda_results$states, 10)
  p3 <- ggplot(top_10_states, aes(x = reorder(state, total_emissions), y = total_emissions)) +
        geom_bar(stat = "identity", fill = "darkred", alpha = 0.7) + coord_flip() +
        labs(title = "Top 10 States by Total Emissions", x = "State", y = "Total Emissions (Tons)") + theme_minimal()
  ggsave(file.path(output_dir, "top_states.png"), plot = p3, width = 10, height = 7, dpi = 300)


}

modeling <- function(data, output_dir){
    model_data <- data |>
        group_by(pollutant) |>
        filter(n() > 50) |>
        ungroup() |>
        mutate(
      county_id = str_remove(county, "^.*- "),
      county_id = factor(county_id),
      log_emissions = log10(emissions + 1),
      region = case_when(
        state %in% c("California", "Oregon", "Washington") ~ "West",
        state %in% c("Texas", "Florida", "Georgia") ~ "South",
        state %in% c("New York", "Pennsylvania", "New Jersey") ~ "Northeast",
        state %in% c("Illinois", "Ohio", "Michigan") ~ "Midwest",
        TRUE ~ "Other"
      ),
      region = factor(region)
    ) |>
  filter(emissions <= quantile(emissions, 0.99, na.rm = TRUE))
  
  write_csv(model_data, file.path(output_dir, "modeling_data.csv"))
  
  return(model_data)

}

models <- function(model_data, output_dir){
    models <- list() 
    model_definitions <- list(
    model1 = list(
      name = "Random Intercept",
      formula = log_emissions ~ pollutant + (1 | county_id),
      family = gaussian()
    ),
    model2 = list(
      name = "Random Intercept with Region",
      formula = log_emissions ~ pollutant + region + (1 | county_id),
      family = gaussian()
    )
  )
  
  for (i in seq_along(model_definitions)) {
    model_name <- names(model_definitions)[i]
    model_def <- model_definitions[[model_name]]
    
    cat("  Fitting", model_def$name, "...\n")
    
    tryCatch({
      model <- glmmTMB(
        formula = model_def$formula,
        data = model_data,
        family = model_def$family
      )
      
      models[[model_name]] <- model
      
      # Save model summary to text file
      sink(file.path(output_dir, paste0(model_name, "_summary.txt")))
      print(summary(model))
      sink()
      
      
    }, error = function(e) {
      cat("Something Went wrong!")
    })
  }
  
  return(models)
}

compare_models <- function(models,output_dir){
  comparison_data <- data.frame()
  
  for (model_name in names(models)) {
    model <- models[[model_name]]
    
    if (!is.null(model)) {
      comparison_data <- rbind(comparison_data, data.frame(
        Model = model_name,
        AIC = AIC(model),
        BIC = BIC(model),
        LogLik = as.numeric(logLik(model)),
        Converged = ifelse(model$fit$convergence == 0, "Yes", "No"),
        stringsAsFactors = FALSE
      ))
    }
  }
  
  if (nrow(comparison_data) > 0) {
    write_csv(comparison_data, file.path(output_dir, "model_comparison.csv"))
  } else {
    cat("Error...While_Comparsion!")
  }
  
  return(comparison_data)
}


results <- air_pollution_analysis()