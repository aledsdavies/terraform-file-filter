/**
  The source location where you can find the files relative to the terraform
*/
variable "files_src" {
  type = string
}

/**
  The file filter use this to filter the files and add configurations
*/
variable "file_filters" {
  type = list(map(any))
}