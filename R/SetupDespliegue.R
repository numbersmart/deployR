#' Setup inicial de despliegue
#'
#' Instala paquetes necesarios y crea variables para guardar y tomar scripts localmente.
#'
#' @param folder_datos Path a folder donde esperamos guardar los datos.
#' @param folder_scripts Path a folder donde esperamos guardar los scripts.
#' @return Variables guardadas localmente en sesion
#'
#' @author Eduardo Flores (Numbersmart)
#'
#' @examples
#' \dontrun{
#' # Usado por sus efectos secundarios
#' }
#' @export
SetupDespliegue <- function(folder_datos, folder_scripts, mailpassword) {
  # ++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # Clean folders

  if(!(grepl(pattern = "/$", x = folder_scripts))){
    folder_scripts <- paste0(folder_scripts, "/")
  }

  if(!(grepl(pattern = "/$", x = folder_datos))){
    folder_datos <- paste0(folder_datos, "/")
  }

  # ++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # List of packages for session
  .packages = c("ggplot2", "dplyr", "magrittr", "rvest", "stringi", "stringr",
                "inegiR", "devtools", "lubridate", "mailR", "htmlTable", "SOAR", "twitteR")

  # Install CRAN packages (if not already installed)
  .inst <- .packages %in% installed.packages()
  if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst],
                                                     dependencies = TRUE)
  # Load packages into session
  lapply(.packages, require, character.only=TRUE)

  # devtool eem
  .gitpackages <- "eem"
  .instgit <- .gitpackages %in% installed.packages()
  if(length(.gitpackages[!.instgit]) > 0) devtools::install_github("Eflores89/eem")

  lapply(.gitpackages, require, character.only=TRUE)

  # ++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # setup scripts
  ns_var_datos <<- folder_datos
  ns_var_scripts <<- folder_scripts

  # ++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # token INEGI
  ns_var_token_inegi <<- "61c36253-47f6-c616-034e-7bf43b1aaba4"

  # ++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # mail password
  ns_var_emailpass <<- mailpassword

  # ++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # NM General utility script
  utility <- paste0(folder_scripts, "GeneralUtilities.R")
  source(utility)
}
