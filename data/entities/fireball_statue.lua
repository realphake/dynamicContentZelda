custom_entity = ...

local attack_on = false

local map, hero
local x, y
local interval = 4000

function custom_entity:attack()
  local son_name = self:get_name() .. "_son_1"
  local son = map:create_enemy{
      name = son_name,
      breed = "red_projectile",
      x = x,
      y = y,
      layer = 2,
      direction=0
    }
  sol.timer.start(self, 500, function()
    sol.audio.play_sound("boss_fireball")
    son:go(angle)
  end)
end

function custom_entity:start()
  if not attack_on then
	  attack_on = true
	  sol.timer.start(self, math.random(1000, 3000), function()
	  	self:check()
	  end)
  end
end

function custom_entity:stop()
  attack_on = false
end

function custom_entity:check()
  local distance = self:get_distance(hero)
  if attack_on then
    if distance < 200 then self:attack() end
    sol.timer.start(self, interval, function()
      self:check()
    end)
  end
end

function custom_entity:set_interval(milliseconds)
	interval = milliseconds
end

function custom_entity:on_created()
	map = self:get_map()
	hero = map:get_entity("hero")
	x, y = self:get_position()
	self:set_traversable_by(false)
	self:create_sprite("entities/fireball_statue")
	self:start()
end
