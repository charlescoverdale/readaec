utils::globalVariables(c(
  # AEC raw column names
  "divisionnm", "divisionid", "stateab", "partyab", "partynm",
  "givennm", "surname", "totalvotes", "swing",
  "liberal/national coalition votes",
  "liberal/national coalition percentage",
  "australian labor party votes",
  "australian labor party percentage",
  # get_swing computed columns
  ".data", "division_id", "alp_pct", "lnp_pct",
  "state.x", "state.y",
  "alp_pct_from", "alp_pct_to", "alp_swing",
  "lnp_pct_from", "lnp_pct_to", "lnp_swing",
  "winner_from", "winner_to", "seat_changed",
  "redistribution_flag", "year_from", "year_to"
))
