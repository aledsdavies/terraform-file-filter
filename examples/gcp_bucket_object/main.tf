module "filter_files" {
  source = "../.."

  base_dir    = "../build"
  filters = [
    {
      regex : ".html$"
      contentType  = "text/html"
      cacheControl = "Cache-Control: max-age=0"
    },
    {
      regex : ".css$"
      contentType  = "text/css"
      cacheControl = "Cache-Control: max-age=31536000, must-revalidate"
    },
    {
      regex : ".js$"
      contentType  = "text/javascript"
      cacheControl = "Cache-Control: max-age=31536000, must-revalidate"
    },
    {
      regex : ".json$"
      contentType  = "text/html"
      cacheControl = "Cache-Control: max-age=0"
    },
    {
      regex : ".svg$"
      contentType  = "image/svg+xml"
      cacheControl = "Cache-Control: max-age=31536000, must-revalidate"
    },
    {
      regex : "sitemap.xml$"
      contentType  = "text/rss+xml"
      cacheControl = "Cache-Control: max-age=0, s-max-age=600"
    },
  ]
}

variable "bucket" {
  type    = string
  default = "made_up"
}


resource "google_storage_bucket_object" "files" {
  for_each = module.filter_files.files
  name     = each.value.path
  source = each.value.src
  cache_control = each.value.cacheControl
  content_type = each.value.contentType
  bucket   = var.bucket
}