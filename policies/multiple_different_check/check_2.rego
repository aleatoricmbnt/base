package terraform
import future.keywords.in



allowed_team_is_present {
    some team in input.tfrun.created_by.teams
    team.name == "allow"
}

deny[reason] {
    not allowed_team_is_present
    reason := "The 'allow' value is required in the 'teams' array"

}
