function table.length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function math.dropchanse(chanse)
	if not chanse or not tonumber(chanse) or tonumber(chanse) < 0 then
		outputDebugString("Nem kapott megfelelő értéket!",3,255,255,255)
	return
	end
	if chanse == 0 then	return false end
	if chanse == 100 then return true end
	local multiplier = 1
	while chanse > 0 and chanse < 1	do
		chanse = chanse*10
		multiplier = multiplier*10
	end
	number = math.random(1,100*multiplier)
	if chanse <= number then
		return true
	elseif chanse > number then
		return false
	end
end

function dropmultiplier ()
	local amount = 1
	if math.dropchanse(15) == true then
		amount = 2
	elseif math.dropchanse(5) == true then
		amount = 3
	end
	return amount
end

function getElementSpeed(theElement)
    local speedx, speedy, speedz = getElementVelocity ( theElement )
	local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
	local kmh = actualspeed * 180
	return kmh
end

function getVehicleMaxSpeed(vehicle)
	local maxSpeed = getVehicleHandling(vehicle)["maxVelocity"] 
	local actualmaxspeed = (maxSpeed/50)
	local kmh = actualmaxspeed * 180
	return maxSpeed
	
end

function getGroundMaterial(x, y, z)
  local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z, x, y, z - 10, true, false, false, true, false, false, false, false, nil)
  return material
end
function isInBuilding(x, y, z)
  local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z, x, y, z + 10, true, false, false, true, false, false, false, false, nil)
  if hit then
    return true
  end
  return false
end
function isObjectAroundPlayer2(thePlayer, distance, height)
  material_value = 0
  local x, y, z = getElementPosition(thePlayer)
  for i = math.random(0, 360), 360 do
    local nx, ny = getPointFromDistanceRotation(x, y, distance, i)
    local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z + height, nx, ny, z + height, true, false, false, false, false, false, false, false)
    if material == 0 then
      material_value = material_value + 1
    end
    if material_value > 40 then
      return 0, hitX, hitY, hitZ
    end
  end
  return false
end
function isObjectAroundPlayer(thePlayer, distance, height)
  local x, y, z = getElementPosition(thePlayer)
  for i = math.random(0, 360), 360 do
    local nx, ny = getPointFromDistanceRotation(x, y, distance, i)
    local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z + height, nx, ny, z + height)
    if material == 0 then
      return material, hitX, hitY, hitZ
    end
  end
  return false
end
function getPointFromDistanceRotation(x, y, dist, angle)
  local a = math.rad(90 - angle)
  local dx = math.cos(a) * dist
  local dy = math.sin(a) * dist
  return x + dx, y + dy
end