resource "google_project_service" "iam_service" {
  service                    = "iamcredentials.googleapis.com"
  disable_dependent_services = true
}

resource "google_iam_workload_identity_pool" "workload_identity_pool" {
  provider                  = google-beta
  workload_identity_pool_id = "github-actions-pool"
  display_name              = "github-actions-pool"
  description               = "Identity pool for Github Actions"
}

resource "google_iam_workload_identity_pool_provider" "workload_identity_pool_provider" {
  provider                           = google-beta
  workload_identity_pool_id          = google_iam_workload_identity_pool.workload_identity_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions"
  description                        = "github-actions"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account" "service_account" {
  account_id   = "github-actions-iam"
  display_name = "github-actions-iam"
}

resource "google_service_account_iam_member" "admin-account-iam" {
  service_account_id = google_service_account.service_account.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.workload_identity_pool.name}/attribute.repository/${var.github_user_name}/${var.github_repository_name}"
}

resource "google_storage_bucket_iam_member" "github_actions_write" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.service_account.email}"
}
