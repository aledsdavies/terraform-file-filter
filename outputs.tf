output "files" {
  value = local.files
  description = "A map of the files that have been filtered that can be used directly in a for_each"
}