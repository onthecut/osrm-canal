api_version = 4

function setup()
  return {
    properties = {
      weight_name                     = 'duration',
    }
  }
end

function process_node(profile, node, result, relations)

  if(node:get_value_by_key('waterway') == 'lock_gate')
  then
    result.traffic_lights = true
    result.barrier = false
  end

end

function process_way(profile, way, result, relations)

  local data = {
    waterway = way:get_value_by_key('waterway'),
    boat = way:get_value_by_key('boat'),
    motorboat = way:get_value_by_key('motorboat')
  }

  if (not data.waterway or not (data.boat or data.motorboat))
  then
    return
  end

  if (not (data.boat == 'yes' or data.moterboat == 'yes'))
  then
    return
  end

  result.duration = 1
  result.forward_speed = 5
  result.forward_mode = mode.driving
  result.backward_speed = 5
  result.backward_mode = mode.driving
  result.name = way:get_value_by_key('name')
end

function process_turn(profile, turn)

end

return {
  setup = setup,
  process_way = process_way,
  process_node = process_node,
  process_turn = process_turn
}
