connection: "lookerdata"

include: "/views/*.view.lkml"


explore: ga_sessions {
  extends: [ga_sessions_block]
}
