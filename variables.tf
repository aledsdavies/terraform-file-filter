variable "storage_bucket_name" {
  type = string
  default = "made_up"
}

/**
  The source location where you can find the files relative to the terraform
*/
variable "files_src" {
  type    = string
  default = "./examples"
}

/**

*/
variable "file_filters" {
  type    = list(map(any))
  default = [
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