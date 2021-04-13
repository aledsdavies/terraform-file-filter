/**
  The source location where you can find the files relative to the terraform
*/
variable "files_src" {
  type = string
  description = "The source location where you can find the files relative to the terraform"
}

/**
  The file filter use this to filter the files and add configurations
*/
variable "file_filters" {
  type = list(map(any))
  description = "The file filter use this to filter the files and add configurations"

  validation {
    // Fails if the regex value isn't set for one of the maps in the list
    condition = length([for k, v in var.file_filters: v if can(v.regex) == false]) == 0
    error_message = "To filter files the regex value much be set in your configuration."
  }
}