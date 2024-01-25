split_data_into_folds <- function(data, k) {
  # Ensure that the number of folds is valid
  if (k < 2) {
    stop("Number of folds should be at least 2.")
  }
  
  # Get the number of rows in the data frame
  n_rows <- nrow(data)
  
  # Calculate the number of rows in each fold
  rows_per_fold <- floor(n_rows / k)
  
  # Randomly shuffle the indices of the rows
  indices <- sample(1:n_rows)
  
  # Initialize an empty list to store the folds
  folds <- vector("list", length = k)
  
  # Split the data into k folds
  for (i in 1:k) {
    start <- (i - 1) * rows_per_fold + 1
    end <- min(i * rows_per_fold, n_rows)
    
    fold_indices <- indices[start:end]
    folds[[i]] <- data[fold_indices, , drop = FALSE]
  }
  
  return(folds)
}
