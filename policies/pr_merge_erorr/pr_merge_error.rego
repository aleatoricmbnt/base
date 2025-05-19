package terraform

# Deny apply runs from unmerged PRs that are not mergable
deny[msg] {
    # Check if this is an apply run (not a plan)
    input.tfrun.is_destroy == false
    input.tfrun.is_dry == false

    # Check if run is triggered from a GitHub comment
    input.tfrun.source == "comment-azure"

    # Check if this is a PR
    input.tfrun.vcs.pull_request != null

    # Check if PR is not merged
    # input.tfrun.vcs.pull_request.merged_by == null

    # Check if PR has merge errors
    input.tfrun.vcs.pull_request.merge_error != null

    msg := sprintf("Merge error: %s", [input.tfrun.vcs.pull_request.merge_error])
}