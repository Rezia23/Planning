(define (domain sailor)
(:requirements :strips :typing)
(:types place item intoxication social_status state)
    ;<PDDL code for predicates>
(:predicates
  (at ?where - place)
  (owns ?what - item)
  (has_walk_path ?from - place ?to - place)
  (has_sail_path ?from - place ?to - place)
  (is_intoxicated ?how - intoxication)
  (has_status ?what - social_status)
  (is_in_state ?s - state)

)
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
  ;;;drink
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
  ;;;crafting
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


  ;;;forest
  (:action getWood
    :precondition(and
        (at forest)
        (not (owns wood))
    )
    :effect(and
      (owns wood)
    )
  )
  (:action getFlowers
    :precondition(and
        (at forest)
        (not (owns flowers))
    )
    :effect(and
      (owns flowers)
    )
  )
  (:action getMap
    :precondition(and
        (at forest)
        (owns alcohol)
        (not (owns map))
    )
    :effect(and
      (owns map)
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
    )
  )

  ;;;river
  (:action stealBoat
    :precondition(and
        (at river)
        (not (owns boat))
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
  (:action takeBath
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
  ;;; port
   (:action work
    :precondition(and
        (at port)
        (not (owns golden_grain))
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
  ;;; pub
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
  ;;;city
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
  ;;;academy
   (:action study
    :precondition(and
        (at academy)
        (not(owns criminal_record))
        (owns golden_coin)
    )
    :effect(and
      (not (owns golden_coin))
      (has_status captain)
    )
  )
  ;;;sea
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
    )
  )
  (:action findPearl
    :precondition(and
        (at sea)
    )
    :effect(and
        (owns pearl)
    )
  )
  (:action takeBath
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


)
