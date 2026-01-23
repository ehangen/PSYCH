# Course Orientation

script_results_identical <- function(result_name) {
  # Get e
  e <- get('e', parent.frame())
  # Get user's result from global
  if(exists(result_name, globalenv())) {
    user_res <- get(result_name, globalenv())
  } else {
    return(FALSE)
  }
  # Source correct result in new env and get result
  tempenv <- new.env()
  # Capture output to avoid double printing
  temp <- capture.output(
    local(
      try(
        source(e$correct_script_temp_path, local = TRUE),
        silent = TRUE
      ),
      envir = tempenv
    )
  )
  correct_res <- get(result_name, tempenv)
  # Compare results
  all.equal(user_res, correct_res)
}


getState <- function(){
#Whenever swirl is running, its callback is at the top of its call stack.
#Swirl's state, named e, is stored in the environment of the callback.

   environment(sys.function(1))$e
}

# Retrieve the log from swirl's state
getLog <- function(){
 getState()$log
}

go_to_brightspace_if_yes <- function() {
  
  # Get the student's selection from swirl
  selection <- getState()$val
  
  # Your Brightspace quiz URL (replace later)
  BrightspaceURL <- "https://mylearning.suny.edu/d2l/home/2404547"
  
  if (selection == "Yes, I would like the completion code") {
    swirl::swirl_out("Great! You are being redirected to your Brightspace quiz. The completion code is: FirstOne!")
    browseURL(BrightspaceURL)
    return(TRUE)
  } else {
    swirl::swirl_out("You are done with this module!")
    return(FALSE)
  }
}

