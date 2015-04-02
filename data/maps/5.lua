map = ...
local game = map:get_game()

-- Quest dialog 

-----------------------

-- LARGE HUB
-----------------------
--Old guy left:
local oldguyleft_talk=[[
There's this story
about a girl that lost
everything, she was
a real beauty or so 
they say...
Some say her beauty
was magical.
]]
-----------------------
--Old guy right:
local oldguyright_talk=[[
This guy keeps talking 
about a story his
mother told him, no-one
knows if that story is 
actually true.
It's not a story with
a happy ending, the 
girl eventually turned
greedy and reclusive.
]]
-----------------------
--Guy at the market:
local marketguy_talk=[[
Something's fishy about 
this merchant, he never 
moves a muscle and 
yet... he never runs 
out of stock...
And the price for an
apple... Ridiculous...
]]
-----------------------
--merchant:
local apple_price = 5

local merchant_apple=[[
Hey would you like an 
apple... 

Only ]].. apple_price..[[ rupees a piece!
Yes please.
No thanks.
]]

local merchant_no_more_apples=[[
You can't carry any 
more apples. Eat some
an come by again.
]]
--IF talked guy_at_market: 

local merchant_talk=[[
I see you you've been
talking to that guy 
over there, he's been 
accusing me of 
overpricing and holding
back my stock. Don't 
mind him, here's some 
apples on the house. 
]]
--<give apple>

-----------------------
--Old brewer:
local brewer_talk_q1=[[
I've been brewing ale 
and potions most of my 
life, the stuff I make 
is really strong!
But that's probably part 
of the cause for your 
brother's condition...


I want to help!
The witch will help!
How can you help?
]]
   
--<answer 1>
local brewer_talk_q1_ans1=[[
The witch probably 
knows how to brew the
Cure Potion as well.
I hope your father will
forgive me for my 
negligence.
]]

--<answer 2>
local brewer_talk_q1_ans2 =[[
I just need the final
ingredient, the Cure
Flower. Sadly I have 
none in my stash.
The witch will likely 
know where to find it 
in the wild.
]]

local brewer_talk_cure = [[
You've found the 
flower! I'll make you 
the cure right away!
]]

local brewer_talk_after = [[
Hurry to your brother!
]]
-----------------------
--Young fellow:
local youngfellow_talk=[[
If you want something 
done right, you have to 
do it yourself, can't 
trust anyone else...
]]
-----------------------
--Old woman:
local oldwoman_talk_q1=[[
Ohw hello dearie...
Do you have a moment to
listen to an old lady's
stories?
No, I'm in a hurry!
Sure I'll listen.
]]
--<answer 1>
local oldwoman_talk_q1_ans1=[[
Ohw, okay...
]]

--<answer 2>
local oldwoman_story=[[
Once upon a time there
was a young lady in
this town, that young 
girl was liked by all.
Especially the boys,
the other girls however
were jealous of her.
Good looks and riches,
she came from a 
prosporous family. $0


At first the girl would
bring presents and 
new clothes for the
other girls, with no
gratitude in return. $0

But one day the parents
were put to a trial, 
they had been
suspected of using 
magic to further their
wealth. $0
The parents were jailed
and the girl was left
all alone.
The girl no longer had
anything to barter for
people's goodwill. 
With time people would 
pay her less and less
attention and after a
while she disappeared. 
No one knows where she
is now however, because 
this is... 
a very old story.
]]
-----------------------
--Innkeeper:
local innkeeper_talk=[[
I heard what happened
to your kid brother, 
and I can see you're
planning to go into the
woods.
Watch out for monsters!
]]
-----------------------
--Glasses Guy:
local glassesguy_talk=[[
Sometimes it feels like
this is the only town
in the entire world!
Weird isn't it?
]]
-----------------------
--Right twin:
local righttwin_talk_1=[[
Dad says the witch
is like... really old!
That she keeps herself
alive with magic!
]]

--<second time talking>
local righttwin_talk_2=[[
But with magic she
keeps for herself...
]]

--Left twin:
local lefttwin_talk_1=[[
Mom says the witch
is like... real smart!
There's so much stuff
that only she knows.
]]
--<second time talking>
local lefttwin_talk_2=[[
But she doesn't want
to share any of it...
]]
-----------------------
--little guy at bushes:
local littleguy_talk=[[
I lost my milk bottle 
in the bushes, can you 
help me find it?
]]

--IF bottle_1 then:
local littleguy_gotbottle=[[
Ahw it's empty, my milk
was spilled. You can
keep the bottle.
]]
-----------------------

function lefttwin:on_interaction()
	if game:get_value("lefttwin_talked") then
		game:start_dialog("test.variable", lefttwin_talk_2)
	else
		game:set_value("lefttwin_talked", true)
		game:start_dialog("test.variable", lefttwin_talk_1)
	end
end

function righttwin:on_interaction()
	if game:get_value("righttwin_talked") then
		game:start_dialog("test.variable", righttwin_talk_2)
	else
		game:set_value("righttwin_talked", true)
		game:start_dialog("test.variable", righttwin_talk_1)
	end
end

function glassesguy:on_interaction()
	game:start_dialog("test.variable", glassesguy_talk)
end

function oldwoman:on_interaction()
	game:start_dialog("test.question", oldwoman_talk_q1, function(answer) 
		if answer==1 then
			game:start_dialog("test.variable", oldwoman_talk_q1_ans1)
		else
			game:start_dialog("test.variable", oldwoman_story)
		end
	end)
end

function oldguyleft:on_interaction()
	game:start_dialog("test.variable", oldguyleft_talk)
end

function oldguyright:on_interaction()
	game:start_dialog("test.variable", oldguyright_talk)
end

function innkeeper:on_interaction()
	game:start_dialog("test.variable", innkeeper_talk)
end

function youngfellow:on_interaction()
	game:start_dialog("test.variable", youngfellow_talk)
end

function merchant:on_interaction()
	if game:get_value("marketguy_talked") and not game:get_value("free_apples") 
		and (not game:has_item("apples_counter") or game:get_item("apples_counter"):get_amount() <= 7 ) then
		game:start_dialog("test.variable", merchant_talk, function() 
			hero:start_treasure("apple", 1, "free_apples")
		end)
	else
		game:start_dialog("test.question", merchant_apple, function(answer) 
			if answer == 1 and game:get_money() >= apple_price 
				and (not game:has_item("apples_counter") or game:get_item("apples_counter"):get_amount() < 10) then 
				game:remove_money(apple_price)
				hero:start_treasure("apple_single", 1)
			elseif answer == 1 and game:has_item("apples_counter") and game:get_item("apples_counter"):has_amount(10) then
				sol.audio.play_sound("wrong")
				game:start_dialog("test.variable", merchant_no_more_apples)
			elseif answer == 1 and game:get_money() < apple_price then
				sol.audio.play_sound("wrong")
				game:start_dialog("_shop.not_enough_money")
			end
		end)
	end
end

function marketguy:on_interaction()
	game:set_value("marketguy_talked", true)
	game:start_dialog("test.variable", marketguy_talk)
end

function brewer:on_interaction()
	if game:get_value("quest_flower") then
		game:set_value("quest_flower", false)
		game:start_dialog("test.variable", brewer_talk_cure, function() 
			hero:start_treasure("cure", 1, "strong_cure", function()
				game:start_dialog("test.variable", brewer_talk_after)
            end)
		end)
	elseif game:get_value("strong_cure") or game:get_value("diluted_cure") then
		game:start_dialog("test.variable", brewer_talk_after)
	else
		game:start_dialog("test.question", brewer_talk_q1, function(answer) 
			if answer==1 then
				game:start_dialog("test.variable", brewer_talk_q1_ans1)
			else
				game:start_dialog("test.variable", brewer_talk_q1_ans2)
			end
		end)
	end
end

function littleguy:on_interaction()
	if game:get_value("bottle_1") then
		game:start_dialog("test.variable", littleguy_gotbottle)
	else
		game:start_dialog("test.variable", littleguy_talk)
	end
end


function quest_reminder_b:on_activated()
	if not game:get_value("quest_flower") then
		game:start_dialog("test.variable", 
[[
I think I'm forgetting 
something...
]])
	else
		quest_block_b:set_enabled(false)
	end
end

function quest_reminder_a:on_activated()
	if game:get_value("quest_flower") then
		quest_block_a:set_enabled(true)
		game:start_dialog("test.variable", 
[[
I have to turn
this Cure Flower
into a potion!
]])
	elseif not game:get_value("mine_key") then
		game:start_dialog("test.variable", 
[[
I think I'm forgetting 
something...
]])
	else
		quest_block_a:set_enabled(false)
	end
	
end

function quest_reminder_d:on_activated()
	if game:get_value("quest_flower") then
		quest_block_d:set_enabled(true)
		game:start_dialog("test.variable", 
[[
I have to turn
this Cure Flower
into a potion!
]])
	else
		quest_block_d:set_enabled(false)
	end
end

function quest_reminder_c:on_activated()
	if not game:get_value("quest_flower") then
		game:start_dialog("test.variable", 
[[
I have to get the
Cure Flower as soon
as possible!
]])
	else
		quest_block_c:set_enabled(false)
	end
end