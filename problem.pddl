(define (problem happy_sailor)
  (:domain sailor)
  (:requirements :strips :typing)
  ;<PDDL code for objects>
  (:objects
    forest river port pub city academy lighthouse sea island - place
    wood golden_grain golden_coin golden_brick ship alcohol flowers map pearl ring cocain goods criminal_record boat fregata caravel coconuts bear_fur - item
    dubious_contacts good_contacts smuggler_friends tough captain is_impressive proposed defeated_pirates - social_status
    sober buzzed drunk addicted - intoxication
    can_sail happy - state )
  ;<PDDL code for initial state>
  (:init

    (at port)
    (has_walk_path forest river)
    (has_walk_path river forest)
    (has_walk_path river port)
    (has_walk_path port river)
    (has_walk_path pub port)
    (has_walk_path port pub)
    (has_walk_path city port)
    (has_walk_path port city)
    (has_walk_path city academy)
    (has_walk_path academy city)
    (has_sail_path port lighthouse)
    (has_sail_path lighthouse port)
    (has_sail_path port sea)
    (has_sail_path sea port)
    (has_sail_path sea island)
    (has_sail_path island sea)
    (has_sail_path sea lighthouse)
    (has_sail_path lighthouse sea)
    (is_intoxicated sober)
  )


  (:goal (and (is_in_state happy) ) )

)
