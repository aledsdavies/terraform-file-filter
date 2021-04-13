# Terraform module for filtering file

This is a util-only Terraform module that filters all the files in a directory based on the filter criteria. It will 
then merge 

## Usage 

```hcl
module "file-filter" {
  source  = "aledsdavies/file-filter/util"
  version = "0.1.0"
  # insert the 2 required variables here
  
  base_dir = "../build"

  // You can insert multiple filters into the array to configure different file types individually
  filters = [
    {
      // The regex value is used to filter 
      regex : ".html$"
      // This field is the only required field

      // Additional values can be added and these will get merged with the output
      contentType  = "text/html"
      cacheControl = "Cache-Control: max-age=0"
    },
  ]
}
```

## Example output based the example in usage

```hcl
  + files = {
      + files = {
          + subfolder/subfolder.html = {
              + cacheControl = "Cache-Control: max-age=0"
              + contentType  = "text/html"
              + file_name    = "subfolder.html"
              + path         = "subfolder/subfolder.html"
              + regex        = ".html$"
              + src          = "../build/subfolder/subfolder.html"
            }
          + test.html                = {
              + cacheControl = "Cache-Control: max-age=0"
              + contentType  = "text/html"
              + file_name    = "test.html"
              + path         = "test.html"
              + regex        = ".html$"
              + src          = "../build/test.html"
            }
        }
    }
```

## Deploying to a GCP Bucket

```hcl
resource "google_storage_bucket_object" "files" {
  for_each = module.filtered_files.files
  name     = each.value.path
  source = each.value.src
  cache_control = each.value.cacheControl
  content_type = each.value.contentType
  bucket   = "example"
}
```

## Deploying to AWS S3
```hcl
resource "aws_s3_bucket_object" "files" {
  for_each = module.filtered_files.files

  bucket       = "example"
  key          = each.value.path
  
  content_type = each.value.contentType
  cache_control = each.value.cacheControl
  
  source  = each.value.src
  content = each.value.content
  etag = filemd5(each.src)
}
```

## Requirements

This module requires Terraform v0.13.0 or later. It does not use any Terraform providers, and does not declare any
Terraform resources.

## Authors

Aled Davies

Currently, maintained by [these contributors](../../graphs/contributors).

## License

MIT License. See [LICENSE](LICENSE) for full details.