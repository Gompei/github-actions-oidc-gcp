resource "google_storage_bucket" "bucket" {
  name     = "example-github-actions-oidc-gcp"
  location = "asia-northeast1"
  # バケットを削除する場合、このブールオプションは含まれているすべてのオブジェクトを削除します。
  force_destroy               = true
  uniform_bucket_level_access = false

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_storage_default_object_access_control" "access_control" {
  bucket = google_storage_bucket.bucket.name
  role   = "READER"
  entity = "allUsers"
}
