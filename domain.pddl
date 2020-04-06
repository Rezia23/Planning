(define (domain sailor)
(:requirements :strips :typing)
(:types place item intoxication social_status state)
(:predicates
  (at ?where - place)
  (owns ?what - item)
  (has_walk_path ?from - place ?to - place)
  (has_sail_path ?from - place ?to - place)
  (is_intoxicated ?how - intoxication)
  (has_status ?what - social_status)
  (is_in_state ?s - state)
  (can_give_map)
  (pearl_in_sea)
  (boat_stealable)

)
;;;;;;;; Movement
  (:action walk
    :parameters (?from - place ?to - place)
    :precondition(and
      (at ?from)
      (has_walk_path ?from ?to)
    )
    :effect(and
      (not (at ?from))
      (at ?to)
    )
  )

  (:action sail
    :parameters (?from - place ?to - place)
    :precondition(and
      (at ?from)
      (has_sail_path ?from ?to)
      (is_in_state can_sail)
    )
    :effect(and
      (not (at ?from))
      (at ?to)
    )
  )
;;;;;;;; Drinking
  (:action getBuzzed
    :precondition(and
        (owns alcohol)
        (is_intoxicated sober)
    )
    :effect(and
      (not(owns alcohol))
      (not(is_intoxicated sober))
      (is_intoxicated buzzed)
    )
  )
  (:action getDrunk
    :precondition(and
        (owns alcohol)
        (is_intoxicated buzzed)
    )
    :effect(and
      (not(owns alcohol))
      (not(is_intoxicated buzzed))
      (is_intoxicated drunk)
    )
  )
  (:action getAddicted
    :precondition(and
        (owns alcohol)
        (is_intoxicated drunk)
    )
    :effect(and
      (not(owns alcohol))
      (not(is_intoxicated drunk))
      (is_intoxicated addicted)
    )
  )
;;;;;;;; Crafting
  (:action makeBoat
    :precondition(and
        (owns wood)
    )
    :effect(and
        (not(owns wood))
        (owns boat)
        (is_in_state can_sail)
    )
  )
(:action makeFregata
    :precondition(and
        (owns boat)
        (owns wood)
        (owns golden_grain)
    )
    :effect(and
        (not(owns boat))
        (not(owns wood))
        (not(owns golden_grain))
        (owns fregata)
    )
  )
  (:action makeCaravel
    :precondition(and
        (owns boat)
        (owns wood)
        (owns golden_coin)
    )
    :effect(and
        (not(owns boat))
        (not(owns wood))
        (not(owns golden_coin))
        (owns caravel)
    )
  )
  (:action makeRing
    :precondition(and
        (owns golden_brick)
        (owns pearl)
    )
    :effect(and
        (not(owns golden_brick))
        (not(owns pearl))
        (owns ring)

    )
  )


;;;;;;;; Forest
  (:action getWoodF
    :precondition(and
        (at forest)
    )
    :effect(and
      (owns wood)
    )
  )
  (:action getFlowers
    :precondition(and
        (at forest)
    )
    :effect(and
      (owns flowers)
    )
  )
  (:action getMap
    :precondition(and
        (at forest)
        (owns alcohol)
        (can_give_map)
    )
    :effect(and
      (owns map)
      (not(owns alcohol))
      (has_status dubious_contacts)
    )
  )
  (:action fightBear
    :precondition(and
        (at forest)
    )
    :effect(and
        (owns bear_fur)
        (has_status tough)
        (has_status is_impressive)
    )
  )

;;;;;;;; River
  (:action stealBoat
    :precondition(and
        (at river)
        (boat_stealable)
    )
    :effect(and
      (owns boat)
      (is_in_state can_sail)
      (owns criminal_record)
    )
  )
  (:action getGoldenGrain
    :precondition(and
        (at river)
        (not (owns golden_grain))
    )
    :effect(and
      (owns golden_grain)
    )
  )
  (:action takeBathR
    :precondition(and
        (at river)
        (not (is_intoxicated sober))
        (not (is_intoxicated addicted))
    )
    :effect(and
      (is_intoxicated sober)
      (not (is_intoxicated buzzed))
      (not (is_intoxicated drunk))
    )
  )
;;;;;;;; Port
   (:action work
    :precondition(and
        (at port)
    )
    :effect(and
      (owns golden_grain)
    )
  )
   (:action tradeFur
    :precondition(and
        (at port)
        (owns bear_fur)
    )
    :effect(and
      (not (owns bear_fur))
      (owns golden_coin)
    )
  )
  (:action tradeCoconuts
    :precondition(and
        (at port)
        (owns coconuts)
    )
    :effect(and
      (not (owns coconuts))
      (owns golden_coin)
    )
  )
  (:action meetSmugglers
    :precondition(and
        (at port)
        (has_status dubious_contacts)
        (owns golden_brick)
    )
    :effect(and
      (has_status smuggler_friends)
    )
  )
;;;;;;;; Pub
  (:action getAlcohol
    :precondition(and
        (at pub)
        (owns golden_grain)
    )
    :effect(and
      (owns alcohol)
      (not (owns golden_grain))
    )
  )

  (:action buyARound
    :precondition(and
        (at pub)
        (owns golden_coin)
    )
    :effect(and
      (has_status good_contacts)
      (not(owns golden_coin))
    )
  )
  (:action fight
    :precondition(and
        (at pub)
        (is_intoxicated buzzed)
    )
    :effect(and
      (has_status tough)
    )
  )
;;;;;;;; City
   (:action spareInBank
    :precondition(and
        (at city)
        (owns golden_grain)
    )
    :effect(and
      (not(owns golden_grain))
      (owns golden_coin)
      (has_status good_contacts)
    )
  )
    (:action investInBank
    :precondition(and
        (at city)
        (owns golden_coin)
    )
    :effect(and
      (not(owns golden_coin))
      (owns golden_brick)
      (has_status good_contacts)
    )
  )
    (:action steal
    :precondition(and
        (at city)
    )
    :effect(and
      (owns golden_coin)
      (owns criminal_record)
    )
  )
  (:action buyIndulgence
    :precondition(and
        (at city)
        (owns criminal_record)
        (owns golden_grain)
    )
    :effect(and
      (not(owns golden_grain))
      (not (owns criminal_record))
    )
  )
  (:action doCommunityWork
    :precondition(and
        (at city)
        (owns criminal_record)
    )
    :effect(and
      (not (owns criminal_record))
      (is_intoxicated buzzed)
      (not(is_intoxicated sober))
      (not(is_intoxicated drunk))
      (not(is_intoxicated addicted))
    )
  )
;;;;;;;; Academy
   (:action study
    :precondition(and
        (at academy)
        (not(owns criminal_record))
        (owns golden_coin)
    )
    :effect(and
      (not (owns golden_coin))
      (has_status captain)
      (has_status is_impressive)
    )
  )
;;;;;;;; Sea
   (:action getRobbed
    :precondition(and
        (at sea)
        (not(has_status tough))
    )
    :effect(and
      (not(owns golden_grain))
      (not(owns golden_coin))
      (not(owns golden_brick))
      (not(owns boat))
      (not(owns fregata))
      (not(owns caravel))
    )
  )
  (:action joinPirates
    :precondition(and
        (at sea)
        (has_status dubious_contacts)
    )
    :effect(and
        (is_intoxicated buzzed)
        (not(is_intoxicated sober))
        (not(is_intoxicated drunk))
        (not(is_intoxicated addicted))
    )
  )
  (:action fightPirates
    :precondition(and
        (at sea)
        (has_status tough)
        (owns caravel)
    )
    :effect(and
        (owns boat)
        (owns caravel)
        (owns fregata)
        (owns golden_grain)
        (owns golden_coin)
        (owns golden_brick)
        (has_status is_impressive)
        (has_status defeated_pirates)
    )
  )
  (:action findPearl
    :precondition(and
        (at sea)
        (pearl_in_sea)
    )
    :effect(and
        (owns pearl)
    )
  )
  (:action takeBathP
    :precondition(and
        (at port)
        (not(is_intoxicated addicted))

    )
    :effect(and
        (not(is_intoxicated drunk))
        (not(is_intoxicated buzzed))
        (is_intoxicated sober)
    )
  )
;;;;;;;; Lighthouse
  (:action propose
    :precondition(and
        (at lighthouse)
        (owns ring)
        (owns flowers)
        (has_status is_impressive)
    )
    :effect(and
        (has_status proposed)
        (not(owns ring))
        (not(owns flowers))
    )
  )
;;;;;;;; Island
  (:action getCoconuts
    :precondition(and
        (at island)
    )
    :effect(and
        (owns coconuts)
    )
  )
  (:action getWoodI
    :precondition(and
        (at island)
    )
    :effect(and
        (owns wood)
    )
  )
  (:action getCocain
    :precondition(and
        (at island)
        (owns map)
    )
    :effect(and
        (owns cocain)
    )
  )
;;;;;;;; Becoming happy
  (:action getMarried
    :precondition(and
        (has_status good_contacts)
        (has_status proposed)
        (not(owns criminal_record))
        (not(is_intoxicated drunk))
        (not(is_intoxicated addicted))
    )
    :effect(and
        (is_in_state happy)
    )
  )
  (:action becomeAdmiral
    :precondition(and
        (has_status captain)
        (has_status defeated_pirates)
        (at academy)
        (not(is_intoxicated buzzed))
        (not(is_intoxicated drunk))
        (not(is_intoxicated addicted))
    )
    :effect(and
        (is_in_state happy)
    )
  )
  (:action becomeCrackhead
    :precondition(and
        (owns cocain)
        (is_intoxicated addicted)
        (owns fregata)
        (has_status smuggler_friends)
        (owns golden_brick)
    )
    :effect(and
        (is_in_state happy)
    )
  )


)
