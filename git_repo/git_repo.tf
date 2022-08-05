resource "github_repository" "example" {
  name        = "terraform_git_test"
  description = "My awesome codebase"

  visibility = "public"
}